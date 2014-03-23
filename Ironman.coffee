#!/bin/env node

dict = require './dict'
generator = require './generator'

gen = new generator(dict, 2, 4, 5, 0.1)
console.log gen.next()
