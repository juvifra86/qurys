--select distinct R.[04_Cuenta],init--,  R.* 											
--from ResultadosBuroCredito  AS R with (nolock)											
											
--where											
											
--cast(init as date)= (select MAX(init) from ResultadosBuroCredito where [04_Cuenta] = r.[04_Cuenta])--'20160331'											
											
--and finish is null --and PeriodoId=5											
											
--and [04_Cuenta] in	

	select * from ResultadosBuroCredito with (nolock) 
where 
cast(init as date)='20160331' 
and finish is null 
and [04_Cuenta] in									
('3141073','8023014','9025047','9022074','8022112','9025126','9010069','00835001690','09411001813','07056002581','10025061','10669094',											
											
'10681045','10681136','10681148','10682011','10682013','10683109','10669049','07046005437','09591005528','08191005573','02741005594',											
											
'20511005639','20321005954','20421005973','20831006586','20281006593','21011006654','20371006699','20521006759','20821006798',											
											
'21011006969','20321007381','20511007647','20521007713','21001007870','20551007884','20271008253','20571007377','21021007525',											
											
'20321007706','10000024768','20621007848','20571007872','21171007896','20381008114','20321008143','20821008163','20271008188',											
											
'20571008530','20271009510','20301010198','20521010014','20321010022','20291010637','20541010642','20241010668','20541010691',											
											
'21071010790','20571010924','20371011712','20491011803','20361011814','20621011044','20491011233','27121012629','20271007039',											
											
'20271007242','20581007246','20331007270','21731007274','20621007282','20271007284','20321007286','20381007288','20271007292',											
											
'20321007322','20371007325','20521007333','20331007338','20331007340','20571007341','20381007358','20271007363','21741007382',											
											
'20331007388','20421007393','20331007397','20311007398','20281007401','20271007404','20281007408','20321007424','20371007426',											
											
'20261007438','20331007443','20271007449','20371007452','20271007453','20321007454','20621007457','20371007458','20311007461',											
											
'21081007467','20371007472','20331007485','20321007486','20331007489','20381007495','20281007516','20331007517','20321007522',											
											
'20271007524','20331007533','20271007534','20311007535','20271007536','20371007549','20281007553','20321007556','20371007557',											
											
'20321007558','20281007574','20301007585','20331007594','20771007596','10000024037','20281007606','20321007608','20371007615',											
											
'20371007620','20371007634','20831007636','20331007642','20321007648','20371007666','20281007667','20331007680','20331007683',											
											
'20321007686','20621007705','20621007716','20331007718','20321007720','20831007721','20321007722','20271007729','20371007732',											
											
'20621007733','20361007735','20631007736','20311007738','21021007746','20371007748','20371007749','20871007762','21071007768',											
											
'20381007770','20271007771','20331007775','21071007781','20271007793','20561007794','20621007795','20331007801','20371007809',											
											
'20381007810','20331007814','20381007817','20271007818','20621007819','20321007820','20531007830','20271007835','22158007836',											
											
'20281007840','20321007841','20271007843','21071007845','20371007847','20301007864','20321007866','20271007868','20261007871',											
											
'20511007873','20361007874','20271007876','20321007879','20271007885','20621007887','20671007890','20381007901','20381007904',											
											
'20411007909','20531007912','20781007923','20581007942','20281007976','20631007981','21121007982','20571007985','20271008057',											
											
'20321008092','20271008122','20371008126','20511008138','21741008142','20321008149','20371008151','20271008162','20501008176',											
											
'20281008182','20301008186','20381008187','20621008212','20261008235','20631008262','20571008268','20421008282','20571008308',											
											
'20621008337','20621008346','20631008380','21011008394','20621008401','22378008406','20631008416','20621008461','20621008467',											
											
'20581008475','20611008480','20631008490','22378008511','20421008540','20571008603','20621008604','20661008640','20571008644',											
											
'20421008694','20631008695','21071008697','20511008709','22378008757','441041','3045128','441052','602100','6006036','9003041',											
											
'3098046','8005022','3142069','6023114','512069','3016004','442072','3096104','3094122','6008051','4054104','4098138','7021035',											
											
'7005012','8008012','8007022','8004129','8007113','8023086','436044','7006012','511062','4086028','9012099','419103','4042040',											
											
'3017073','8024023','514111','4081122','439052','221074','20002076','20003110','10032126','10034107','10036063','10043017','10044096',											
											
'10045146','10046017','30101026','30101045','10049031','10053106','30104016','10054071','20002054','30151019','30106029','10041003',											
											
'20521035','20522020','20522021','10339127','10371014','27521014301') 											
--ORDER BY r.init, R.[04_Cuenta]											
