#!/usr/bin/env python
# -*- coding: utf-8 -*-
#
# Sorry, the comments are all in Chinese because this project highly relies on Chinese Language.
#
# 示例程序
#

import Ironman, wordslist

if __name__ == "__main__":
	instance = Ironman.Ironman(wordslist.wordslist)
	print instance.generate()
	print instance.generate(0x10, 0x10)
