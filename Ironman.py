# -*- coding: utf-8 -*-
#
# Sorry, the comments are all in Chinese because this project highly relies on Chinese Language.
#

import sys, copy, random, types

class Ironman:
	def __init__(self, dictionary, len_min=1, len_max=3):
		self.thedict = copy.deepcopy(dictionary)
		self.len_min=1
		self.len_max=3
		self.__calc_weight(self.thedict)

	# 调试时输出词典
	#def __dump_dict(d):
	#	import json
	#	print json.dumps(d, ensure_ascii=False, indent=4)

	# 由可能不完整的属性表a根据默认属性产生完整的属性表
	def ___get_attr(self, a):
		attr = {
			"c_lim": -1,		# 使用次数（-1为无限）
			"_w_attr": 1,		# 定语内权值总和（构造函数生成）
			"_w_end": 1,		# 中心词内权值总合（构造函数生成）
			"w_attr": 1,		# 定语权值（-1则视内容多少而定）
			"w_end": 1,			# 中心词权值（-1则视内容多少而定）
			"end": False,		# 同时可用于定语的中心词在作中心词时的后缀
			"sw_attr": False,	# 定语权值是否为-1（构造函数生成）
			"sw_end": False		# 中心词权值是否为-1（构造函数生成）
		}
		for key in attr:
			if a.has_key(key):
				attr[key] = a[key]
		return attr

	# 取得node节点的属性表
	def __get_attr(self, node):
		if type(node) is types.TupleType:
			return self.___get_attr(node[0])
		else:
			return self.___get_attr({"c_lim": 1}) # 单个字串默认限用一次

	# 随机产生定语个数
	def __length(self, len_min, len_max):
		return random.randint(len_min, len_max)

	# 冗余计算词典中的权值
	# 返回值：(定语权值, 中心词权值)
	def __calc_weight(self, node):
		if type(node) is types.StringType:
			return (1, 1)
		elif type(node) is types.TupleType:
			attr = self.__get_attr(node)
			
			# 计算内权值总和
			_w_attr = 0
			_w_end = 0
			for i in range(len(node[1])):
				if type(node[1][i]) is types.ListType: # 为列表添加属性表，方便处理
					node[1][i] = ({}, node[1][i])
				tw_attr, tw_end = self.__calc_weight(node[1][i])
				_w_attr += tw_attr
				_w_end += tw_end
			node[0]["_w_attr"] = _w_attr
			node[0]["_w_end"] = _w_end
			
			# 计算外权值
			if attr["w_attr"] == -1:
				node[0]["sw_attr"] = True
				node[0]["w_attr"] = _w_attr
				attr["w_attr"] = _w_attr
			if attr["w_end"] == -1:
				node[0]["sw_end"] = True
				node[0]["w_end"] = _w_end
				attr["w_end"] = _w_end
			
			return (attr["w_attr"], attr["w_end"])

	# 随机取得定语（t=="attr"）或中心词（t=="end"）
	# 返回值：(结果, 定语权值减小量, 中心词权值减小量)
	def __pick(self, node, t="attr"):
		if type(node) is types.StringType:
			return (node, 0, 0)
		else:
			attr = self.__get_attr(node)
			r = random.randint(1, attr["_w_"+t]) # 在内权值总和范围内产生随机数
			i = 0
			while r > 0: # 计算中标子节点
				curr = node[1][i]
				attr_c = self.__get_attr(curr)
				r -= attr_c["w_"+t]
				i += 1
			ret, dw_attr, dw_end = self.__pick(curr, t)
			attr_c = self.__get_attr(curr)
			
			if attr_c["c_lim"] != -1: # 有限制
				attr_c["c_lim"] -= 1
			if (attr_c["c_lim"] == 0) or (type(curr) is types.TupleType and curr[1] == []): # 节点应被移除
				if attr_c["sw_attr"]:
					dw_attr = attr_c["w_attr"]
				else:
					dw_attr = 0
				if attr_c["sw_end"]:
					dw_end = attr_c["w_end"]
				else:
					dw_end = 0
				node[0]["_w_attr"] -= attr_c["w_attr"]
				node[0]["_w_end"] -= attr_c["w_end"]
				del node[1][i - 1]
			else:
				curr[0]["c_lim"] = attr_c["c_lim"]
				node[0]["_w_attr"] -= dw_attr
				node[0]["_w_end"] -= dw_end
			if (type(attr["end"]) is types.StringType) and (t == "end"):
				ret = ret + attr["end"]
			return (ret, dw_attr, dw_end)

	def generate(self, len_min=-1, len_max=-1): # 产生完整词
	
		# 使用默认长度
		if len_min == -1:
			len_min = self.len_min
		if len_max == -1:
			len_max = self.len_max
		
		thedict = copy.deepcopy(self.thedict) # 以免多次使用吃光词库
		word = self.__pick(thedict, "end")[0] # 取得中心词
		for i in range(self.__length(len_min, len_max)): # 按长度取得定语
			word = self.__pick(thedict)[0] + word
		return word
