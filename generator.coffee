random = require './randomlib'

class generator

	constructor: (dict, @len_min, @len_opt, @len_max, @p_suffix) ->
		@_dict 		= dict

		@get_word = (type) ->
			r = parseInt Math.random() * if type == 'main' then @dict.tw_main else @dict.tw_modifier
			for group in @dict.words_groups
				r -= if type == 'main' then group.w_main else group.w_modifier
				if r <= 0
					(--group.w_main; --@dict.tw_main) if group.w_main
					(--group.w_modifier; --@dict.tw_modifier) if group.w_modifier
					r = parseInt Math.random() * group.words_list.length
					ret =
						word: group.words_list[r]
						tags: group.tags

					group.words_list.splice r, 1
					return ret

		@can_have_suffix = (tags, type) ->
			for tag in tags
				t = tag
				while true
					return true if @dict.suffix[t]? and @dict.suffix[t][type].length > 0
					break if t in ['main', 'modifier', 'other']
					t = @dict.taglist[t].parent
			false

		@must_have_suffix = (tags, type) ->
			for tag in tags
				return false if @dict.taglist[tag].root == type
			true

		@need_suffix = (tags, p_suffix, type) ->
			return true if @must_have_suffix(tags, type)
			return @can_have_suffix(tags, type) if Math.random() <= p_suffix

		@get_suffix = (tags, type) ->
			suffixes = []
			for tag in tags
				t = tag
				while true
					suffixes.push @dict.suffix[t][type]... if @dict.suffix[t]
					break if t in ['main', 'modifier', 'other']
					t = @dict.taglist[t].parent
			suffixes[parseInt(Math.random() * suffixes.length)]

	next: ()->
		@dict = JSON.parse(JSON.stringify(@_dict))

		main = @get_word('main')
		if @need_suffix(main.tags, @p_suffix, 'main')
			main.word += @get_suffix(main.tags, 'main').word

		modifiers = []
		order = []

		length = random(@len_min, @len_opt, @len_max) - 1
		for i in [1..length]
			modifiers.push @get_word('modifier')
		
		# add suffix
		for modifier in modifiers
			if @need_suffix(modifier.tags, @p_suffix, 'modifier')
				suffix = @get_suffix(modifier.tags, 'modifier')
				modifier.word += suffix.word
				modifier.tags = [suffix.tag]
		
		# order modifiers
		words =
			default: []
		for otag in @dict.order when otag isnt 'default'
			words[otag] = []
			for modifier in modifiers
				b = false
				for tag in modifier.tags
					t = tag
					while true
						if t == otag and not modifier['used']
							words[otag].push modifier.word
							modifier['used'] = true
							b = true
							break
						break if t in ['main', 'modifier', 'other']
						t = @dict.taglist[t].parent
					break if b
			words[otag].sort (a, b) ->
				b.length - a.length
		for otag in @dict.order
			if otag == 'default'
				for modifier in modifiers when not modifier['used']
					order.push modifier['word']
			else
				order.push words[otag]...

		order.join('') + main.word

module.exports = generator
