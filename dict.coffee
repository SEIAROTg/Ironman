dictlib = require './dictlib'

module.exports = dictlib.create_dict (builder) ->
	
	builder.register_tag 'single', 'modifier' # single character modifier
	builder.register_tag 'de', 'modifier' # '的' or similiar words contained modifier
	builder.register_tag 'person', 'main'
	builder.register_tag 'verb', 'other'
	
	builder.register_tag 'v2n', 'main', ['verb'], 'suffix'
	builder.register_tag 'v2p', 'person', ['verb'], 'suffix'
	builder.register_tag 'n2p', 'person', ['main'], 'suffix'
	builder.register_tag 'a2d', 'de', ['modifier'], 'suffix'
	builder.register_tag 'n2d', 'de', ['main'], 'suffix'

	builder.set_order [
		'de'
		'modifier'
		'single'
	]

	builder.words_add -1, ['v2n'], ['机', '器', '车', '厂', '队', '匠', '术']
	builder.words_add -1, ['v2p', 'n2p'], ['协会', '专家', '爱好者', '积极分子', '分子', '好手', '行家']
	builder.words_add -1, ['a2d', 'n2d'], ['版']
	builder.words_add -1, ['n2d'], ['牌']
	builder.words_add -1, ['n2p'], ['贩子']

	builder.words_add 1, ['single'], ['小', '大']
	builder.words_add 1, ['single'], ['土', '洋']
	builder.words_add 1, ['modifier'], ['家养', '野生']
	builder.words_add 1, ['modifier'], ['军用', '民用']
	builder.words_add 1, ['modifier'], ['肥子', '瘦子']
	builder.words_add 1, ['modifier'], ['新制', '陈酿']
	builder.words_add 1, ['modifier'], ['混编', '整编']
	builder.words_add 1, ['modifier'], ['无水', '注水']
	builder.words_add 1, ['modifier'], ['公共', '私人']
	builder.words_add 1, ['modifier'], ['廉价', '免费']
	builder.words_add 1, ['modifier'], ['劣质', '优质']
	builder.words_add 1, ['modifier'], ['寒酸', '豪华']
	builder.words_add 1, ['modifier'], ['增肥', '减肥']
	builder.words_add 1, ['modifier'], ['避孕', '绝育']
	builder.words_add 1, ['modifier'], ['国产', '进口']
	builder.words_add 1, ['modifier'], ['宏观', '微观']
	builder.words_add 1, ['modifier'], ['男式', '女式']
	builder.words_add 1, ['modifier'], ['大头', '断头']
	builder.words_add 1, ['modifier'], ['量子', '相对论']
	builder.words_add 1, ['modifier'], ['免税', '免月租']
	builder.words_add 1, ['modifier'], ['反科学', '反重力']
	builder.words_add 1, ['modifier'], ['食品级', '航天级']
	builder.words_add 1, ['modifier'], ['紫外', '红外', '激光']
	builder.words_add 1, ['modifier'], ['普快', '特快', '空调']
	builder.words_add 1, ['modifier'], ['反动', '革命', '反革命']
	builder.words_add 1, ['modifier'], ['高钙', '补铁', '维生素']
	builder.words_add 1, ['modifier'], ['五彩', '七彩', '黑白', '彩色']
	builder.words_add 1, ['modifier'], ['无烟', '无尘', '节能', '环保']
	builder.words_add 1, ['modifier'], ['东部', '西部', '南部', '北部']
	builder.words_add 1, ['modifier'], ['爱国', '卖国', '叛国', '通敌']
	builder.words_add 1, ['modifier'], ['人力', '畜力', '柴油', '核动力']
	builder.words_add 1, ['modifier'], ['热带', '亚热带', '温带', '寒带']
	builder.words_add 1, ['modifier'], ['美白', '排毒养颜', '红润', '亮白']
	builder.words_add 1, ['modifier'], ['微型', '大型', '大规模', '超大规模']
	builder.words_add 1, ['modifier'], ['集成电路', '电子', '晶体管', '真空管']
	builder.words_add 1, ['modifier'], ['五香', '红烧', '糖醋', '香酱', '高汤', '孜然', '爆炒', '红焖', '清蒸']
	builder.words_add 1, ['modifier'], ['土家', '维吾尔', '蒙古', '乌干达', '肯尼亚', '中非', '东非', '坦桑尼亚', '埃塞俄比亚', '索马里', '阿富汗', '伊拉克', '津巴布韦']
	builder.words_add 2, ['modifier'], ['超级', '加强', '无敌', '终极', '特别', '超值'],
	builder.words_add 2, ['modifier'], ['艾滋', '天花', '非典', '流感', '瘟疫', '梅毒'],
	builder.words_add -1, ['modifier'], ['光杆', '三无', '科幻', '变种', '畸形', '百米', '液压', '高爆', '重口', '特困', '穴居', '缺爱', '高仿', '三防', '有奖', '深海', '安全', '解放', '红头', '新华', '双卡', '太空', '加长', '现代', '全能', '新编'	, '二手', '放心', '无证', '流动', '御用', '清真', '恐怖', '鸡尾', '注音', '和平', '地沟', '在逃', '中正式', '井冈山', '转基因', '北大荒', '高保真', '一次性', '可食用', '狗不理', '老字号']
	builder.words_add -1, ['de'], ['尊敬的', '限量版', '微波炉适用', '经全国中小学教材审定委员会2004年初审通过普通高中课程标准实验']
	builder.words_add 1, ['main'], ['骡子', '毛驴']
	builder.words_add 1, ['main'], ['支票', '承兑汇票']
	builder.words_add 1, ['main'], ['炸弹', '地雷', '手榴弹']
	builder.words_add 1, ['main'], ['咸菜', '榨菜', '袋泡茶']
	builder.words_add 1, ['main'], ['告家长书', '请假条', '通知']
	builder.words_add 1, ['main'], ['海洛因', '吗啡', '鸦片', '大麻']
	builder.words_add 1, ['main'], ['天平', '离心机', '加速器', '移液管', '试管']
	builder.words_add 1, ['main'], ['老虎凳', '铁处女', '十字架', '断头台', '电椅']
	builder.words_add 1, ['main'], ['二锅头', '干红', '汾酒', '白酒', '黄酒', '茅台']
	builder.words_add 1, ['main'], ['羟基', '羧基', '氨基', '羰基', '酮基', '酰胺基']
	builder.words_add 1, ['main'], ['草鞋', '布鞋', '拖鞋', '内裤', '棉毛裤', '牛仔裤']
	builder.words_add 1, ['main'], ['教堂', '厕所', '教室', '图书馆', '体育场', '核电站']
	builder.words_add 1, ['main'], ['大饼', '豆浆', '油条', '馄饨', '土豆', '烧饼', '包子']
	builder.words_add 1, ['main'], ['瓦斯', '煤炭', '煤球', '煤渣', '煤气', '沼气', '天然气', '煤气罐', '液化石油气']
	builder.words_add 1, ['main'], ['披挂', '鞋垫', '手套', '马褂', '西装', '背心', '披风', '斗篷', '斗笠', '白大褂', '皮大衣']
	builder.words_add 1, ['main'], ['苍蝇', '蚊子', '老虎', '狮子', '袋鼠', '熊猫', '黄鼠狼', '藏獒', '蜘蛛', '黄狗', '黑猫', '狗熊', '狐狸', '猴子', '乌鸦', '麻雀']
	builder.words_add 1, ['main'], ['夜壶', '算盘', '板凳', '洗脚盆', '平底锅', '电饭煲', '微波炉', '高压锅', '热水壶', '热水袋', '坐便器', '曲辕犁', '热得快', '千斤顶', '的确良', '地动仪']
	builder.words_add -1, ['main'], ['痣', '菌', '翔', '屁', '狗洞', '罗盘', '火车', '贼船', '真经', '冤家', '胡同', '书生', '跳台', '石膏', '镰刀', '锤子', '客机', '麻子', '雷管', '娃娃', '二狗', '钻石', '棺材', '香皂', '脑子', '麻袋', '卫星', '狗屎', '饲料', '花炮', '火药', '摊位', '泔水', '坟墓', '粪池', '黑手', '铁蛋', '钢镚', '教具', '账本', '公厕', '烈士', '家属', '眷属', '疙瘩', '瘤子', '花招', '原子弹', '下水沟', '核废料', '化合物', '少年宫']
	builder.words_add 1, ['person'], ['太监', '宦官']
	builder.words_add 1, ['person'], ['君子', '小人']
	builder.words_add 1, ['person'], ['俊杰', '草包']
	builder.words_add 1, ['person'], ['老板', '老板娘']
	builder.words_add 1, ['person'], ['学士', '硕士', '博士']
	builder.words_add 1, ['person'], ['乡绅', '地主', '土豪', '州官']
	builder.words_add 1, ['person'], ['步兵', '炮兵', '航空兵', '民兵']
	builder.words_add 1, ['person'], ['校长', '班主任', '老师', '班长']
	builder.words_add 1, ['person'], ['高富帅', '矮穷挫', '白富美', '土肥圆']
	builder.words_add 1, ['person'], ['活佛', '方丈', '住持', '和尚', '尼姑']
	builder.words_add 1, ['person'], ['工人', '农民', '商人', '学生', '知识分子']
	builder.words_add 1, ['person'], ['河伯', '关公', '土地爷', '地藏王', '阎王爷']
	builder.words_add 1, ['person'], ['小明', '小红', '小强', '小刚', '小华', '小娟']
	builder.words_add 1, ['person'], ['司令', '军长', '师长', '旅长', '团长', '营长', '连长', '排长']
	builder.words_add 1, ['person'], ['天子', '诸侯', '皇帝', '知府', '知县', '总督', '巡抚', '节度使']
	builder.words_add 1, ['person'], ['野人', '僵尸', '蜘蛛侠', '超人', '奥特曼', '天仙宝宝', '皮卡丘', '黑猫警长']
	builder.words_add 1, ['person'], ['进士', '状元', '榜眼', '探花', '贡士', '会元', '举人', '解元', '孝廉', '门生', '贡生', '秀才']
	builder.words_add 1, ['person'], ['爸爸', '妈妈', '爷爷', '奶奶', '哥哥', '姐姐', '弟弟', '妹妹', '儿子', '孙子', '老婆', '老公', '后妈', '继父', '犬子']
	builder.words_add 1, ['person'], ['胡子', '律师', '打手', '小丑', '铁匠', '半仙', '理发师', '剃头家', '飞行员', '精神病', '保洁员', '黑社会', '社会活动家', '铁路工人']
	builder.words_add 1, ['person'], ['主席', '总理', '书记', '省长', '市长', '区长', '县长', '乡长', '镇长', '部长', '厅长', '局长', '司长', '处长', '科长', '科员', '股长']
	builder.words_add -1, ['person'], ['痞子', '壮丁', '贼人', '标兵', '走狗', '瞎子', '塔利班', '操盘手', '老佛爷']
	builder.words_add 1, ['modifier', 'verb'], ['防臭', '防水', '防洪', '防火', '抗震', '抗旱', '防盗', '防虫']
	builder.words_add -1, ['modifier', 'verb'], ['自首', '反恐', '维和', '流窜', '辟邪', '放电', '泡足', '穿越', '抢险']
	builder.words_add 1, ['modifier', 'main'], ['左撇子', '右利手']
	builder.words_add 1, ['modifier', 'main'], ['平原', '高原', '盆地', '山地', '丘陵']
	builder.words_add 1, ['modifier', 'main'], ['小鬼', '老头', '儿童', '人民', '首长', '黑户', '文盲', '流氓']
	builder.words_add 2, ['modifier', 'main'], ['赤砂', '红木', '玻璃', '钢筋混凝土', '烂泥', '红砖', '水泥', '白金', '黄金', '红壤', '黑土', '石灰', '瓦片', '槽钢'],
	builder.words_add 1, ['modifier', 'main'], ['资本主义', '社会主义', '共产主义', '无政府主义', '自治主义', '自由主义', '军国主义', '帝国主义', '专制主义', '修正主义']
	builder.words_add 1, ['modifier', 'main'], ['下士', '中士', '上士', '军士长', '学员', '准尉', '少尉', '中尉', '上尉', '大尉', '少校', '中校', '上校', '大校', '准将', '少将', '中将', '上将', '大将', '元帅']
	builder.words_add -1, ['modifier', 'main'], ['山寨', '大棚', '爱心', '闪电', '耗油', '麻油', '贫民窟']
	builder.words_add 1, ['verb'], ['吸尘', '坐便']
	builder.words_add 1, ['verb'], ['蚕食', '侵吞']
	builder.words_add 1, ['verb'], ['手推', '购物', '婴儿', '摩托', '三轮', '皮卡']
	builder.words_add 1, ['verb'], ['造币', '发电', '砖瓦', '火柴', '瓷砖', '锅炉', '炼油', '电机', '制片', '制药', '化工']
	builder.words_add 1, ['verb'], ['剃头', '打火', '打鼾', '洗衣', '电视', '蒸汽', '缝纫', '收音', '录音', '计算', '学习', '点读', '饮水']
	builder.words_add -1, ['verb'], ['吃素', '护法', '派遣', '从良', '讨伐', '暴沸', '拆迁', '爆头', '哭穷', '仇富', '注射', '休克', '运尸', '消防', '游击', '拖拉', '抄家', '甄别', '如厕', '观摩', '打铁', '诈尸', '挖坑', '蹲坑', '开拔', '搬砖', '查水表', '土洋结合']
