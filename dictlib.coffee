util = require "util"

DictError = (msg, constr) ->
	this.message = msg || 'dict error'
util.inherits DictError, Error
DictError.prototype.name = 'DictError'

create_dict = (callback) ->
	return new dict callback

class dict
	constructor: (callback) ->

		builder = new dict_builder
		callback builder

		@taglist 		= builder.taglist
		@order 			= builder.order
		@words_groups 	= builder.words_groups
		@suffix			= builder.suffix

		tw = @words_groups.reduce (a, b) -> # random total weight
				w_main	: a.w_main + b.w_main
				w_modifier	: a.w_modifier + b.w_modifier
		@tw_main = tw.w_main
		@tw_modifier = tw.w_modifier


class dict_builder

	constructor: () ->
		@order 			= ['modifier']
		@words_groups 	= []
		@words_list 	= []
		@suffix			= {}
		@taglist		=
			modifier:
				root: 'modifier'
			main:
				root: 'main'
			other:
				root: 'other'

	###
	register_tag name, parent, targets, type
		
		register new tag

		name
			name of the tag to register

		parent
			specify the parent tag for new tag
			by default, there are three tags: modifier, main, other

		targets
			(modifier only) a whitelist of tags that this tag can modify
			(main only) a whitelist of tags that can modify this tag
			by default, the tag can modify or be modify by any tags

		type (modifier only)
			specify the type of tag, prefix or suffix
			by default, the type is prefix
	###
	register_tag: (name, parent, targets, type) ->

		# check if the tag already exists
		if name of @taglist
			throw new DictError "duplicate tag registeration: #{name}"

		# check if the root of tag is legal
		try
			root = parent
			root = @taglist[root].parent until root in ['modifier', 'main', 'other']
		catch
			throw new DictError "unknown root of tag: #{name}"

		@taglist[name] =
			parent	: parent
			root	: root

		@taglist[name].targets = targets if targets?

		@taglist[name].type = if type? then type else 'prefix'

		if type == 'suffix'
			for target in targets
				unless @suffix[target]?
					@suffix[target] =
						'modifier'	: []
						'main'		: []


	###
	words_add max_use, tags, words_list
		
		add new words

		max_use
			a number that specific how many times to use these words at most
			-1 means unlimited

		tags
			an array of tags

		words_list
			an array that contains words to add

	###
	words_add: (max_use, tags, words_list) ->

		# check if there is duplicate word
		for word in words_list
			if word in @words_list
				throw new DictError "duplicate word: #{word}"
			for w in words_list
				throw new DictError "duplicate word: #{word}" if (_i != _j and w == word)

		# check for unregistered tag
		for tag in tags
			throw new DictError "unregistered tag: #{tag}" unless @taglist[tag]?

		max_use = words_list.length if max_use == -1

		if max_use > words_list.length
			throw new DictError "max_use is longer than words_list"

		can_be_main = false
		can_be_modifier = false # if this word group can be a non-suffix and non-main word

		for tag in tags
			if @taglist[tag].type == 'suffix'
				parent = @taglist[tag].parent
				root = @taglist[parent].root
				for target in @taglist[tag].targets
					for word in words_list
						@suffix[target][root].push
							word: word
							tag: parent
			else
				can_be_main = true if @taglist[tag].root == 'main'
				can_be_modifier = true if @taglist[tag].root == 'modifier'
				t = tag
				while true
					if @suffix[t]?
						can_be_main = true if @suffix[t]['main'].length > 0
						can_be_modifier = true if @suffix[t]['modifier'].length > 0
					break if t in ['main', 'modifier', 'other']
					t = @taglist[t].parent

		@words_list.push words_list...
		
		@words_groups.push
			max_use		: max_use
			tags		: tags
			words_list	: words_list
			w_main		: if can_be_main then max_use else 0	# random weight
			w_modifier	: if can_be_modifier then max_use else 0	# random weight

	###
	set_order order_list

		set order for modifier

		order_list
			a list of tags ordered from left to right

		by default, the order is [modifier]
	###
	set_order: (order_list) ->
		console.warn 'WARN: "modifier" doesn\'t appear in order list' unless 'modifier' in order_list
		@order = order_list.slice()


module.exports =
	create_dict: create_dict
