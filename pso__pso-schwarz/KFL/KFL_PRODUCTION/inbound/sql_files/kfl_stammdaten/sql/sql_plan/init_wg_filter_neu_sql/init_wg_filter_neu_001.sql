DELETE FROM DBP_DATA.l_wg_filter;
DELETE FROM DBP_DATA.wg_filter_spr_zu;
DELETE FROM DBP_DATA.wg_filter_zu;

INSERT INTO  DBP_DATA.l_wg_filter ( wg_filter_id, kommentar) VALUES (1, 'Abteilung A06,A07');
INSERT INTO  DBP_DATA.wg_filter_spr_zu ( wg_filter_id, spr_id, wg_filter_bez) VALUES (1, 22, 'Bevorratung');
INSERT INTO  DBP_DATA.l_wg_filter ( wg_filter_id, kommentar) VALUES (2, 'OWG 1013/1014');
INSERT INTO  DBP_DATA.wg_filter_spr_zu ( wg_filter_id, spr_id, wg_filter_bez) VALUES (2, 22, 'Lebend-Blumen/-Pflan');
INSERT INTO  DBP_DATA.l_wg_filter ( wg_filter_id, kommentar) VALUES (3, 'OWG 1008 Backshop');
INSERT INTO  DBP_DATA.wg_filter_spr_zu ( wg_filter_id, spr_id, wg_filter_bez) VALUES (3, 22, 'Backshop');
INSERT INTO  DBP_DATA.l_wg_filter ( wg_filter_id, kommentar) VALUES (4, 'wg_id  between 980 and 989');
INSERT INTO  DBP_DATA.wg_filter_spr_zu ( wg_filter_id, spr_id, wg_filter_bez) VALUES (4, 22, 'Pfand, Cross-Docking, Ladungsträger');
INSERT INTO  DBP_DATA.l_wg_filter ( wg_filter_id, kommentar) VALUES (5, 'wg_id  = 980');
INSERT INTO  DBP_DATA.wg_filter_spr_zu ( wg_filter_id, spr_id, wg_filter_bez) VALUES (5, 22, 'Pfand');
INSERT INTO  DBP_DATA.l_wg_filter ( wg_filter_id, kommentar) VALUES (6, 'OWG 1013, 1014, 1010, 1011, 1012');
INSERT INTO  DBP_DATA.wg_filter_spr_zu ( wg_filter_id, spr_id, wg_filter_bez) VALUES (6, 22, 'Frisch-Obst/-Gemüse, Lebend-Blumen/-Pflan');
INSERT INTO  DBP_DATA.l_wg_filter ( wg_filter_id, kommentar) VALUES (7, 'wg_id NOT IN (122,128,129,131,132,133,148,149,152,153,154,155,156,157,159,168,169,172,173,174,...,659,662,663,664,665,818,950,960,980,981,982,983,183,158,277,179,181,182)');
INSERT INTO  DBP_DATA.wg_filter_spr_zu ( wg_filter_id, spr_id, wg_filter_bez) VALUES (7, 22, '$DBP_DATA.mk_art_wup_auswahl WG-Filter -- Ausschluss bestimmter Warengruppen aus der Abteilung Food');
INSERT INTO  DBP_DATA.l_wg_filter ( wg_filter_id, kommentar) VALUES (8, 'abt_id IN (5,6,7) and HWG not in (H64) bzw. wg_id in (122,128,129,131,132,133,134,135,136,137,138,139,141,142,143,144,145,146,147,148,...,655,656,657,658,659,661,662,663,664,665)');
INSERT INTO  DBP_DATA.wg_filter_spr_zu ( wg_filter_id, spr_id, wg_filter_bez) VALUES (8, 22, 'Food Filter');
INSERT INTO  DBP_DATA.l_wg_filter ( wg_filter_id, kommentar) VALUES (9, 'wg_id IN (968)');
INSERT INTO  DBP_DATA.wg_filter_spr_zu ( wg_filter_id, spr_id, wg_filter_bez) VALUES (9, 22, 'Spenden');
INSERT INTO  DBP_DATA.l_wg_filter ( wg_filter_id, kommentar) VALUES (10, 'wg in (122,128,146,147,184,186)');
INSERT INTO  DBP_DATA.wg_filter_spr_zu ( wg_filter_id, spr_id, wg_filter_bez) VALUES (10, 22, 'Fleisch');
INSERT INTO  DBP_DATA.l_wg_filter ( wg_filter_id, kommentar) VALUES (11, 'wg_id IN (232,233,234,235,236,237,238,239,242,243,244,245,246,247,248,249,251,252,253...591,592,593,594,595,596,597)');
INSERT INTO  DBP_DATA.wg_filter_spr_zu ( wg_filter_id, spr_id, wg_filter_bez) VALUES (11, 22, 'Spezieller Filter für Sortimentstool');
INSERT INTO  DBP_DATA.l_wg_filter ( wg_filter_id, kommentar) VALUES (12, 'OWG in (1010,1011,1012)');
INSERT INTO  DBP_DATA.wg_filter_spr_zu ( wg_filter_id, spr_id, wg_filter_bez) VALUES (12, 22, 'Obst / Gemüse');
INSERT INTO  DBP_DATA.l_wg_filter ( wg_filter_id, kommentar) VALUES (13, 'OWG = 1026');
INSERT INTO  DBP_DATA.wg_filter_spr_zu ( wg_filter_id, spr_id, wg_filter_bez) VALUES (13, 22, 'Fehlmengen');
INSERT INTO  DBP_DATA.l_wg_filter ( wg_filter_id, kommentar) VALUES (14, 'wg_id IN (980,981,982,983,984,985)');
INSERT INTO  DBP_DATA.wg_filter_spr_zu ( wg_filter_id, spr_id, wg_filter_bez) VALUES (14, 22, 'Leergut');
INSERT INTO  DBP_DATA.l_wg_filter ( wg_filter_id, kommentar) VALUES (15, '(mandant_id = 1 AND wg_id IN (122,128,184,146,147,186)) OR (mandant_id = 2 AND wg_id IN( 768,782,783,784,785,786,787,791,792,797,825))');
INSERT INTO  DBP_DATA.wg_filter_spr_zu ( wg_filter_id, spr_id, wg_filter_bez) VALUES (15, 22, 'Fleisch 2');
INSERT INTO  DBP_DATA.l_wg_filter ( wg_filter_id, kommentar) VALUES (16, 'wg_id <> 983');
INSERT INTO  DBP_DATA.wg_filter_spr_zu ( wg_filter_id, spr_id, wg_filter_bez) VALUES (16, 22, '/* WG <> 983 mögliche AKL Leerbehälter */');
INSERT INTO  DBP_DATA.l_wg_filter ( wg_filter_id, kommentar) VALUES (17, 'wg_id NOT IN (122,128,183,184,146,147,186,161,162,163,164,18,148,321,322,323,324,325,326,327,149,152,153,154,155,156,157,282,283,284,285,286,288,289,293,294)');
INSERT INTO  DBP_DATA.wg_filter_spr_zu ( wg_filter_id, spr_id, wg_filter_bez) VALUES (17, 22, '_wabi_man_bestellungen');
INSERT INTO  DBP_DATA.l_wg_filter ( wg_filter_id, kommentar) VALUES (18, 'wg_id NOT IN (122,128,134,135,136,137,138,139,141,142,144,146,147,158,159,184,186,232,233,234,235,236,237,238,239,242,243,244,245,246,331,183,329,185,188)');
INSERT INTO  DBP_DATA.wg_filter_spr_zu ( wg_filter_id, spr_id, wg_filter_bez) VALUES (18, 22, '_WGs fuer Ermittlung PM_ID');
INSERT INTO  DBP_DATA.l_wg_filter ( wg_filter_id, kommentar) VALUES (19, 'wg_id in (146,147,186)');
INSERT INTO  DBP_DATA.wg_filter_spr_zu ( wg_filter_id, spr_id, wg_filter_bez) VALUES (19, 22, 'Anreichern Aktionkennzeichen./Identifikation Artikel-Markt-Tag in Aktion analog zu AIS KMO.');
INSERT INTO  DBP_DATA.l_wg_filter ( wg_filter_id, kommentar) VALUES (20, 'Bereich B02 - entspricht Abteilung 8 lt. A.Wolter');
INSERT INTO  DBP_DATA.wg_filter_spr_zu ( wg_filter_id, spr_id, wg_filter_bez) VALUES (20, 22, 'Nonfood');
INSERT INTO  DBP_DATA.l_wg_filter ( wg_filter_id, kommentar) VALUES (21, 'Bereich B02 - entspricht Abteilung 8 lt. A.Wolter');
INSERT INTO  DBP_DATA.wg_filter_spr_zu ( wg_filter_id, spr_id, wg_filter_bez) VALUES (21, 22, 'Ermittlung EK Mep 1');
INSERT INTO  DBP_DATA.l_wg_filter ( wg_filter_id, kommentar) VALUES (22, 'Bereich B02 - entspricht Abteilung 8 lt. A.Wolter');
INSERT INTO  DBP_DATA.wg_filter_spr_zu ( wg_filter_id, spr_id, wg_filter_bez) VALUES (22, 22, 'Ermittlung EK Mep 2');
INSERT INTO  DBP_DATA.l_wg_filter ( wg_filter_id, kommentar) VALUES (23, 'wg_id in (122,128,146,147,184,186) and mandant_id in (1,2)');
INSERT INTO  DBP_DATA.wg_filter_spr_zu ( wg_filter_id, spr_id, wg_filter_bez) VALUES (23, 22, 'EKPO flw_fg');
INSERT INTO  DBP_DATA.l_wg_filter ( wg_filter_id, kommentar) VALUES (24, 'mandant_id = 1 AND wg_id IN (797,798,799,823,829,805,806,824,808,812,813,794,811,822,772,773,774,809,804,807,825,819)');
INSERT INTO  DBP_DATA.wg_filter_spr_zu ( wg_filter_id, spr_id, wg_filter_bez) VALUES (24, 22, 'NPD-Group Export');
INSERT INTO  DBP_DATA.l_wg_filter ( wg_filter_id, kommentar) VALUES (25, 'mandant_id = 1 AND wg_id NOT IN (122,128,184,146,147,186,134,135,...,149,152,153,154,155,156,157,179,181,182,148)');
INSERT INTO  DBP_DATA.wg_filter_spr_zu ( wg_filter_id, spr_id, wg_filter_bez) VALUES (25, 22, 'AVQ (DE) Bestellartenausschluss');
INSERT INTO  DBP_DATA.l_wg_filter ( wg_filter_id, kommentar) VALUES (26, 'mandant_id > 1 AND wg_id NOT IN (122,128,184,146,147,186,183,185,161,162,163,164,282,283,284,285,...152,153,154,155,156,157,179,181,182,148)');
INSERT INTO  DBP_DATA.wg_filter_spr_zu ( wg_filter_id, spr_id, wg_filter_bez) VALUES (26, 22, 'AVQ (KMO) Bestellartenausschluss');
INSERT INTO  DBP_DATA.l_wg_filter ( wg_filter_id, kommentar) VALUES (27, 'mandant_id = 1 AND wg_id IN (134,135,136,137,138,139,141,142,144,183,143,145,187,179,181,182)');
INSERT INTO  DBP_DATA.wg_filter_spr_zu ( wg_filter_id, spr_id, wg_filter_bez) VALUES (27, 22, 'AVQ (DE) 3 Tage vor Werbebeginn');
INSERT INTO  DBP_DATA.l_wg_filter ( wg_filter_id, kommentar) VALUES (28, 'mandant_id = 1 AND wg_id IN (122,128,183,184,146,147,186,185,148)');
INSERT INTO  DBP_DATA.wg_filter_spr_zu ( wg_filter_id, spr_id, wg_filter_bez) VALUES (28, 22, 'AVQ (DE) 1 Tag vor Werbebeginn');
INSERT INTO  DBP_DATA.l_wg_filter ( wg_filter_id, kommentar) VALUES (29, 'mandant_id > 1 AND wg_id IN (122,128,183,184,146,147,186,185,282,283,284,285,286,288,289,293,294,148)');
INSERT INTO  DBP_DATA.wg_filter_spr_zu ( wg_filter_id, spr_id, wg_filter_bez) VALUES (29, 22, 'AVQ (KMO) 3 Tage vor Werbebeginn');
INSERT INTO  DBP_DATA.l_wg_filter ( wg_filter_id, kommentar) VALUES (30, 'abt_id IN (8)');
INSERT INTO  DBP_DATA.wg_filter_spr_zu ( wg_filter_id, spr_id, wg_filter_bez) VALUES (30, 22, 'AVQ (DE/KMO) Nonfood');
INSERT INTO  DBP_DATA.l_wg_filter ( wg_filter_id, kommentar) VALUES (31, 'wg_id IN (534 ,535 ,536 ,537 ,538 ,539 ,541 ,542 ,543 ,544 ,545 ,546 ,547 ,548 ,549 ,...,584 ,658 ,662 ,663 ,664 ,665 )');
INSERT INTO  DBP_DATA.wg_filter_spr_zu ( wg_filter_id, spr_id, wg_filter_bez) VALUES (31, 22, 'Getränke (Shopper)');
INSERT INTO  DBP_DATA.l_wg_filter ( wg_filter_id, kommentar) VALUES (32, 'Bereich B02 - entspricht Abteilung 8 lt. A.Wolter');
INSERT INTO  DBP_DATA.wg_filter_spr_zu ( wg_filter_id, spr_id, wg_filter_bez) VALUES (32, 22, 'Fremdsortiment 1 (ARTBEW)');
INSERT INTO  DBP_DATA.l_wg_filter ( wg_filter_id, kommentar) VALUES (33, 'wg_id BETWEEN 960 AND 968');
INSERT INTO  DBP_DATA.wg_filter_spr_zu ( wg_filter_id, spr_id, wg_filter_bez) VALUES (33, 22, 'Fremdsortiment 2 (ARTBEW)');
INSERT INTO  DBP_DATA.l_wg_filter ( wg_filter_id, kommentar) VALUES (34, 'wg_id BETWEEN 970 AND 979');
INSERT INTO  DBP_DATA.wg_filter_spr_zu ( wg_filter_id, spr_id, wg_filter_bez) VALUES (34, 22, 'Fremdsortiment 3 (ARTBEW)');
INSERT INTO  DBP_DATA.l_wg_filter ( wg_filter_id, kommentar) VALUES (35, 'wg_id IN (818,969)');
INSERT INTO  DBP_DATA.wg_filter_spr_zu ( wg_filter_id, spr_id, wg_filter_bez) VALUES (35, 22, 'MIS-Filter 1 (ARTBEW)');
INSERT INTO  DBP_DATA.l_wg_filter ( wg_filter_id, kommentar) VALUES (36, 'abt_id (5,6,7)');
INSERT INTO  DBP_DATA.wg_filter_spr_zu ( wg_filter_id, spr_id, wg_filter_bez) VALUES (36, 22, 'Bon Sergmente FIlter');
INSERT INTO  DBP_DATA.l_wg_filter ( wg_filter_id, kommentar) VALUES (37, 'wg_id in (122,128,129,131,132,133,134,135,136,137,138,139,141,142,143,144,...,329,188,247,248,249,251,252,253,254,255,256,267,258,259)');
INSERT INTO  DBP_DATA.wg_filter_spr_zu ( wg_filter_id, spr_id, wg_filter_bez) VALUES (37, 22, 'Bon Umsatz Brutto Filter');
INSERT INTO  DBP_DATA.l_wg_filter ( wg_filter_id, kommentar) VALUES (38, 'wg_id IN (818,969)');
INSERT INTO  DBP_DATA.wg_filter_spr_zu ( wg_filter_id, spr_id, wg_filter_bez) VALUES (38, 22, 'MIS-Telefonkarten (ARTBEW)');
INSERT INTO  DBP_DATA.l_wg_filter ( wg_filter_id, kommentar) VALUES (39, 'wg_id IN (980,981)');
INSERT INTO  DBP_DATA.wg_filter_spr_zu ( wg_filter_id, spr_id, wg_filter_bez) VALUES (39, 22, 'Kasse_pfand in BON');
INSERT INTO  DBP_DATA.l_wg_filter ( wg_filter_id, kommentar) VALUES (40, 'OWG 1091');
INSERT INTO  DBP_DATA.wg_filter_spr_zu ( wg_filter_id, spr_id, wg_filter_bez) VALUES (40, 22, 'Kasse_Tueten in BON');
INSERT INTO  DBP_DATA.l_wg_filter ( wg_filter_id, kommentar) VALUES (43, 'wg_temp_id IN (402, 403, 404, 405, 406, 407, 408, 409, 411, 412, 413, 414  .....  653, 654, 655, 656, 657, 658, 659, 661)');
INSERT INTO  DBP_DATA.wg_filter_spr_zu ( wg_filter_id, spr_id, wg_filter_bez) VALUES (43, 22, 'Sortimentstool KMO FB Definition für wg_temp)');
INSERT INTO  DBP_DATA.l_wg_filter ( wg_filter_id, kommentar) VALUES (44, 'wg_id IN (534,535,536,537,538,539,541,542,...,581,582,583,584 )');
INSERT INTO  DBP_DATA.wg_filter_spr_zu ( wg_filter_id, spr_id, wg_filter_bez) VALUES (44, 22, 'AVQ (DE) Bier/AFG');
INSERT INTO  DBP_DATA.l_wg_filter ( wg_filter_id, kommentar) VALUES (45, 'wg_id IN (523,524,525,526)');
INSERT INTO  DBP_DATA.wg_filter_spr_zu ( wg_filter_id, spr_id, wg_filter_bez) VALUES (45, 22, 'AVQ (DE/KMO) Süßwaren');
INSERT INTO  DBP_DATA.l_wg_filter ( wg_filter_id, kommentar) VALUES (46, 'wg_id IN (158,188,159)');
INSERT INTO  DBP_DATA.wg_filter_spr_zu ( wg_filter_id, spr_id, wg_filter_bez) VALUES (46, 22, 'AVQ (KMO) Heiße Theke/Grill');
INSERT INTO  DBP_DATA.l_wg_filter ( wg_filter_id, kommentar) VALUES (47, 'wg_id IN (232, 233, 234, 235, 236, 237, 238, 239, 242, 243, 244 ..... 656, 657, 658, 659, 661, 662, 663, 664, 665)');
INSERT INTO  DBP_DATA.wg_filter_spr_zu ( wg_filter_id, spr_id, wg_filter_bez) VALUES (47, 22, 'Sortimentstool KMO FB Definition)');

INSERT INTO DBP_DATA.wg_filter_zu
( mandant_id
, wg_id
, arthiertyp_id
, wg_filter_id
, wug_id)
SELECT
	mandant_id
	, wg_id
	, arthiertyp_id
	, 1 as wg_filter_id
        , -1 as wug_id
FROM DBP_DATA.wg_per
WHERE abt_id in (6,7)
AND arthiertyp_id = 2
AND dat_bis= to_date('9999-12-31','YYYY-MM-DD')
;

INSERT INTO DBP_DATA.wg_filter_zu
( mandant_id
, wg_id
, arthiertyp_id
, wg_filter_id
, wug_id)
SELECT
	mandant_id
	, wg_id
	, arthiertyp_id
	, 2 as wg_filter_id
        , -1 as wug_id
FROM DBP_DATA.wg_per
WHERE owg_id in (1013,1014)
AND arthiertyp_id = 2
AND dat_bis= to_date('9999-12-31','YYYY-MM-DD')
;

INSERT INTO DBP_DATA.wg_filter_zu
( mandant_id
, wg_id
, arthiertyp_id
, wg_filter_id
, wug_id)
SELECT
	mandant_id
	, wg_id
	, arthiertyp_id
	, 3 as wg_filter_id
        , -1 as wug_id
FROM DBP_DATA.wg_per
WHERE owg_id in (1008)
AND arthiertyp_id = 2
AND dat_bis= to_date('9999-12-31','YYYY-MM-DD')
;

INSERT INTO DBP_DATA.wg_filter_zu
( mandant_id
, wg_id
, arthiertyp_id
, wg_filter_id
, wug_id)
SELECT
	mandant_id
	, wg_id
	, arthiertyp_id
	, 4 as wg_filter_id
        , -1 as wug_id
FROM DBP_DATA.wg_per
WHERE wg_id between 980 and 989
AND arthiertyp_id = 2
AND dat_bis= to_date('9999-12-31','YYYY-MM-DD')
;

INSERT INTO DBP_DATA.wg_filter_zu
( mandant_id
, wg_id
, arthiertyp_id
, wg_filter_id
, wug_id)
SELECT
	mandant_id
	, wg_id
	, arthiertyp_id
	, 5 as wg_filter_id
        , -1 as wug_id
FROM DBP_DATA.wg_per
WHERE wg_id = 980
AND arthiertyp_id = 2
AND dat_bis= to_date('9999-12-31','YYYY-MM-DD')
;

INSERT INTO DBP_DATA.wg_filter_zu
( mandant_id
, wg_id
, arthiertyp_id
, wg_filter_id
, wug_id)
SELECT
	mandant_id
	, wg_id
	, arthiertyp_id
	, 6 as wg_filter_id
        , -1 as wug_id
FROM DBP_DATA.wg_per
WHERE owg_id in (1013, 1014, 1010, 1011, 1012)
AND arthiertyp_id = 2
AND dat_bis= to_date('9999-12-31','YYYY-MM-DD')
;

INSERT INTO DBP_DATA.wg_filter_zu
( mandant_id
, wg_id
, arthiertyp_id
, wg_filter_id
, wug_id)
SELECT
	mandant_id
	, wg_id
	, arthiertyp_id
	, 7 as wg_filter_id
        , -1 as wug_id
FROM DBP_DATA.wg_per
WHERE wg_id in (122,128,129,131,132,133,148,149,152,153,154,155,156,157,159,168,
                169,172,173,174,175,176,177,178,184,261,262,263,268,269,272,273,
                274,275,276,278,279,281,328,329,523,524,525,526,534,535,536,537,
                538,539,541,542,543,544,545,546,547,548,549,551,552,553,554,555,
                556,557,558,576,577,578,579,581,582,583,584,603,604,605,658,659,
                662,663,664,665,818,950,960,980,981,982,983,183,158,277,179,181,182)
AND arthiertyp_id = 2
AND dat_bis= to_date('9999-12-31','YYYY-MM-DD')
;

INSERT INTO DBP_DATA.wg_filter_zu
( mandant_id
, wg_id
, arthiertyp_id
, wg_filter_id
, wug_id)
SELECT
	mandant_id
	, wg_id
	, arthiertyp_id
	, 8 as wg_filter_id
        , -1 as wug_id
FROM DBP_DATA.wg_per
WHERE wg_id in (122,128,129,131,132,133,134,135,136,137,138,139,141,142,143,144,145,146,147,148,149,152,153,154,155,156,
                157,158,159,179,181,182,183,184,185,186,187,188,232,233,234,235,236,237,238,239,242,243,244,245,246,247,248,
                249,251,252,253,254,255,256,257,258,259,261,262,263,264,265,266,267,268,269,272,273,274,275,276,277,278,279,
                281,282,283,284,285,286,288,289,293,294,295,296,297,298,299,302,303,304,305,306,307,308,309,311,312,313,314,
                315,316,317,318,319,321,322,323,324,325,326,327,328,329,331,402,403,404,405,406,407,408,409,411,412,413,414,
                415,416,417,418,419,421,422,423,424,425,426,427,428,429,431,432,433,434,435,436,437,438,439,441,442,443,444,
                445,446,447,448,449,452,453,454,455,456,457,458,459,461,462,463,464,465,466,467,468,469,471,473,474,475,476,477,478,481,482,
                483,484,485,486,487,488,489,491,492,493,494,495,496,497,498,499,501,502,503,504,505,506,507,508,509,511,512,513,514,515,516,
                517,518,519,521,522,523,524,525,526,527,528,529,531,532,533,534,535,536,537,538,539,541,542,543,544,545,546,547,548,549,551,552,553,
                554,555,556,557,558,559,561,562,563,564,565,566,567,568,569,571,572,573,574,575,576,577,578,579,581,582,583,584,585,586,587,588,589,
                591,592,593,594,595,596,597,598,599,601,602,603,604,605,606,607,608,609,612,613,614,615,616,617,618,619,622,623,624,625,626,
                627,628,629,631,632,633,634,635,636,637,638,639,644,645,646,647,648,649,651,652,653,654,655,656,657,658,659,661,662,663,664,665)
AND arthiertyp_id = 2
AND dat_bis= to_date('9999-12-31','YYYY-MM-DD')
;

INSERT INTO DBP_DATA.wg_filter_zu
( mandant_id
, wg_id
, arthiertyp_id
, wg_filter_id
, wug_id)
SELECT
	mandant_id
	, wg_id
	, arthiertyp_id
	, 9 as wg_filter_id
        , -1 as wug_id
FROM DBP_DATA.wg_per
WHERE wg_id in (968)
AND arthiertyp_id = 2
AND dat_bis= to_date('9999-12-31','YYYY-MM-DD')
;

INSERT INTO DBP_DATA.wg_filter_zu
( mandant_id
, wg_id
, arthiertyp_id
, wg_filter_id
, wug_id)
SELECT
	mandant_id
	, wg_id
	, arthiertyp_id
	, 10 as wg_filter_id
        , -1 as wug_id
FROM DBP_DATA.wg_per
WHERE wg_id in (122,128,146,147,184,186,191,192)
AND arthiertyp_id = 2
AND dat_bis= to_date('9999-12-31','YYYY-MM-DD')
;

INSERT INTO DBP_DATA.wg_filter_zu
( mandant_id
, wg_id
, arthiertyp_id
, wg_filter_id
, wug_id)
SELECT
	mandant_id
	, wg_id
	, arthiertyp_id
	, 11 as wg_filter_id
        , -1 as wug_id
FROM DBP_DATA.wg_per
WHERE wg_id in (232, 233, 234, 235, 236, 237, 238, 239, 242, 243, 244, 245, 246, 247, 248, 249, 251, 252, 253, 
                254, 255, 256, 257, 258, 259, 261, 262, 263, 264, 265, 266, 267, 268, 269, 272, 273, 274, 275, 
                276, 277, 278, 279, 281, 282, 283, 284, 285, 286, 288, 289, 293, 294, 295, 296, 297, 298, 299, 
                302, 303, 304, 305, 306, 307, 308, 309, 311, 312, 313, 314, 315, 316, 317, 318, 319, 321, 322, 
                323, 324, 325, 326, 327, 328, 331, 402, 403, 404, 405, 406, 407, 408, 409, 411, 412, 413, 414, 
                415, 416, 417, 418, 419, 421, 422, 423, 424, 425, 426, 427, 428, 429, 431, 432, 433, 434, 435, 
                436, 437, 438, 439, 441, 442, 443, 444, 445, 446, 447, 448, 449, 452, 453, 454, 455, 456, 457, 
                458, 459, 461, 462, 463, 464, 465, 466, 467, 468, 469, 471, 473, 474, 475, 476, 477, 478, 481, 
                482, 483, 484, 485, 486, 487, 488, 489, 491, 492, 493, 494, 495, 496, 497, 498, 499, 501, 502, 
                503, 504, 505, 506, 507, 508, 509, 511, 512, 513, 514, 515, 516, 517, 518, 519, 521, 522, 523, 
                524, 525, 526, 527, 528, 529, 531, 532, 533, 534, 535, 536, 537, 538, 539, 541, 542, 543, 544, 
                545, 546, 547, 548, 549, 551, 552, 553, 554, 555, 556, 557, 558, 559, 561, 562, 563, 564, 565, 
                566, 567, 568, 569, 571, 572, 573, 574, 575, 576, 577, 578, 579, 581, 582, 583, 584, 585, 586, 
                587, 588, 589, 591, 592, 593, 594, 595, 596, 597, 598, 599, 601, 602, 603, 604, 605, 606, 607, 
                608, 609, 612, 613, 614, 615, 616, 617, 618, 619, 622, 623, 624, 625, 626, 627, 628, 629, 631, 
                632, 633, 634, 635, 636, 637, 638, 639, 644, 645, 646, 647, 648, 649, 651, 652, 653, 654, 655, 
                656, 657, 658, 659, 661, 662, 663, 664, 665, 122, 128, 129, 131, 132, 133, 134, 135, 136, 137,
                138, 139, 141, 142, 143, 144, 145, 179, 181, 182, 183, 184, 187, 329)
AND arthiertyp_id = 2
AND dat_bis= to_date('9999-12-31','YYYY-MM-DD')
;

INSERT INTO DBP_DATA.wg_filter_zu
( mandant_id
, wg_id
, arthiertyp_id
, wg_filter_id
, wug_id)
SELECT
	mandant_id
	, wg_id
	, arthiertyp_id
	, 12 as wg_filter_id
        , -1 as wug_id
FROM DBP_DATA.wg_per
WHERE owg_id in (1010,1011,1012)
AND arthiertyp_id = 2
AND dat_bis= to_date('9999-12-31','YYYY-MM-DD')
;

INSERT INTO DBP_DATA.wg_filter_zu
( mandant_id
, wg_id
, arthiertyp_id
, wg_filter_id
, wug_id)
SELECT
	mandant_id
	, wg_id
	, arthiertyp_id
	, 13 as wg_filter_id
        , -1 as wug_id
FROM DBP_DATA.wg_per
WHERE owg_id in (1026)
AND arthiertyp_id = 2
AND dat_bis= to_date('9999-12-31','YYYY-MM-DD')
;

INSERT INTO DBP_DATA.wg_filter_zu
( mandant_id
, wg_id
, arthiertyp_id
, wg_filter_id
, wug_id)
SELECT
	mandant_id
	, wg_id
	, arthiertyp_id
	, 14 as wg_filter_id
        , -1 as wug_id
FROM DBP_DATA.wg_per
WHERE wg_id in (980,981,982,983,984,985)
AND arthiertyp_id = 2
AND dat_bis= to_date('9999-12-31','YYYY-MM-DD')
;

INSERT INTO DBP_DATA.wg_filter_zu
( mandant_id
, wg_id
, arthiertyp_id
, wg_filter_id
, wug_id)
SELECT
	mandant_id
	, wg_id
	, arthiertyp_id
	, 15 as wg_filter_id
        , -1 as wug_id
FROM DBP_DATA.wg_per
WHERE (mandant_id = 1 
AND wg_id in (122,128,184,146,147,186,191,192))
OR (mandant_id = 2 
AND wg_id in (768,782,783,784,785,786,787,791,792,797,825))
AND arthiertyp_id = 2
AND dat_bis= to_date('9999-12-31','YYYY-MM-DD')
;

INSERT INTO DBP_DATA.wg_filter_zu
( mandant_id
, wg_id
, arthiertyp_id
, wg_filter_id
, wug_id)
SELECT
	mandant_id
	, wg_id
	, arthiertyp_id
	, 16 as wg_filter_id
        , -1 as wug_id
FROM DBP_DATA.wg_per
WHERE wg_id <> 983
AND arthiertyp_id = 2
AND dat_bis= to_date('9999-12-31','YYYY-MM-DD')
;

INSERT INTO DBP_DATA.wg_filter_zu
( mandant_id
, wg_id
, arthiertyp_id
, wg_filter_id
, wug_id)
SELECT
	mandant_id
	, wg_id
	, arthiertyp_id
	, 17 as wg_filter_id
        , -1 as wug_id
FROM DBP_DATA.wg_per
WHERE wg_id in (122,128,183,184,146,147,186,161,162,163,164,185,148,321,322,323,324,325,326,327,149,152,153,154,155,156,157,282,283,284,285,286,288,289,293,294)
AND arthiertyp_id = 2
AND dat_bis= to_date('9999-12-31','YYYY-MM-DD')
;

INSERT INTO DBP_DATA.wg_filter_zu
( mandant_id
, wg_id
, arthiertyp_id
, wg_filter_id
, wug_id)
SELECT
	mandant_id
	, wg_id
	, arthiertyp_id
	, 18 as wg_filter_id
        , -1 as wug_id
FROM DBP_DATA.wg_per
WHERE wg_id in (122,128,134,135,136,137,138,139,141,142,144,146,147,158,159,184,186,232,233,234,235,236,237,238,239,242,243,244,245,246,331,183,329,185,188)
AND arthiertyp_id = 2
AND dat_bis= to_date('9999-12-31','YYYY-MM-DD')
;

INSERT INTO DBP_DATA.wg_filter_zu
( mandant_id
, wg_id
, arthiertyp_id
, wg_filter_id
, wug_id)
SELECT
	mandant_id
	, wg_id
	, arthiertyp_id
	, 19 as wg_filter_id
        , -1 as wug_id
FROM DBP_DATA.wg_per
WHERE wg_id in (146,147,186)
AND arthiertyp_id = 2
AND dat_bis= to_date('9999-12-31','YYYY-MM-DD')
;

INSERT INTO DBP_DATA.wg_filter_zu
( mandant_id
, wg_id
, arthiertyp_id
, wg_filter_id
, wug_id)
SELECT
	mandant_id
	, wg_id
	, arthiertyp_id
	, 20 as wg_filter_id
        , -1 as wug_id
FROM DBP_DATA.wg_per
WHERE abt_id = 8
AND arthiertyp_id = 2
AND dat_bis= to_date('9999-12-31','YYYY-MM-DD')
;

INSERT INTO DBP_DATA.wg_filter_zu
( mandant_id
, wg_id
, arthiertyp_id
, wg_filter_id
, wug_id)
SELECT
	mandant_id
	, wg_id
	, arthiertyp_id
	, 21 as wg_filter_id
        , -1 as wug_id
FROM DBP_DATA.wg_per
WHERE abt_id = 8
AND arthiertyp_id = 2
AND dat_bis= to_date('9999-12-31','YYYY-MM-DD')
;

INSERT INTO DBP_DATA.wg_filter_zu
( mandant_id
, wg_id
, arthiertyp_id
, wg_filter_id
, wug_id)
SELECT
	mandant_id
	, wg_id
	, arthiertyp_id
	, 22 as wg_filter_id
        , -1 as wug_id
FROM DBP_DATA.wg_per
WHERE abt_id = 8
AND arthiertyp_id = 2
AND dat_bis= to_date('9999-12-31','YYYY-MM-DD')
;

INSERT INTO DBP_DATA.wg_filter_zu
( mandant_id
, wg_id
, arthiertyp_id
, wg_filter_id
, wug_id)
SELECT
	mandant_id
	, wg_id
	, arthiertyp_id
	, 23 as wg_filter_id
        , -1 as wug_id
FROM DBP_DATA.wg_per
WHERE mandant_id in (1,2)
AND wg_id in (122,128,146,147,184,186,191,192)
AND arthiertyp_id = 2
AND dat_bis= to_date('9999-12-31','YYYY-MM-DD')
;

INSERT INTO DBP_DATA.wg_filter_zu
( mandant_id
, wg_id
, arthiertyp_id
, wg_filter_id
, wug_id)
SELECT
	mandant_id
	, wg_id
	, arthiertyp_id
	, 24 as wg_filter_id
        , -1 as wug_id
FROM DBP_DATA.wg_per
WHERE wg_id in (797,798,799,823,829,805,806,824,808,812,813,794,811,822,772,773,774,809,804,807,825,819)
AND arthiertyp_id = 2
AND dat_bis= to_date('9999-12-31','YYYY-MM-DD')
;

INSERT INTO DBP_DATA.wg_filter_zu
( mandant_id
, wg_id
, arthiertyp_id
, wg_filter_id
, wug_id)
SELECT
	mandant_id
	, wg_id
	, arthiertyp_id
	, 25 as wg_filter_id
        , -1 as wug_id
FROM DBP_DATA.wg_per
WHERE wg_id in (122,128,184,146,147,186,134,135,136,137,138,139,141,142,144,183,185,161,162,163,164,165,166,143,145,187,179,181,182,148,191,192,201,202,203,204,205,206,207,208,209,211,212,213,214,215,216,217)
AND mandant_id = 1
AND arthiertyp_id = 2
AND dat_bis= to_date('9999-12-31','YYYY-MM-DD')
;

INSERT INTO DBP_DATA.wg_filter_zu
( mandant_id
, wg_id
, arthiertyp_id
, wg_filter_id
, wug_id)
SELECT
	mandant_id
	, wg_id
	, arthiertyp_id
	, 26 as wg_filter_id
        , -1 as wug_id
FROM DBP_DATA.wg_per
WHERE mandant_id > 1
AND wg_id in (122,128,184,146,147,186,183,185,161,162,163,164,165,166,282,283,284,285,286,288,289,293,294,143,145,187,321,322,323,324,325,326,327,149,152,153,154,155,156,157,179,181,182,148,191,192,201,202,203,204,205,206,207,208,209,211,212,213,214,215,216,217)
AND arthiertyp_id = 2
AND dat_bis= to_date('9999-12-31','YYYY-MM-DD')
;

INSERT INTO DBP_DATA.wg_filter_zu
( mandant_id
, wg_id
, arthiertyp_id
, wg_filter_id
, wug_id)
SELECT
	mandant_id
	, wg_id
	, arthiertyp_id
	, 27 as wg_filter_id
        , -1 as wug_id
FROM DBP_DATA.wg_per
WHERE mandant_id = 1
AND wg_id in (134,135,136,137,138,139,141,142,144,183,143,145,187,179,181,182)
AND arthiertyp_id = 2
AND dat_bis= to_date('9999-12-31','YYYY-MM-DD')
;

INSERT INTO DBP_DATA.wg_filter_zu
( mandant_id
, wg_id
, arthiertyp_id
, wg_filter_id
, wug_id)
SELECT
	mandant_id
	, wg_id
	, arthiertyp_id
	, 28 as wg_filter_id
        , -1 as wug_id
FROM DBP_DATA.wg_per
WHERE mandant_id = 1
AND wg_id in (122,128,183,184,146,147,186,185,148)
AND arthiertyp_id = 2
AND dat_bis= to_date('9999-12-31','YYYY-MM-DD')
;

INSERT INTO DBP_DATA.wg_filter_zu
( mandant_id
, wg_id
, arthiertyp_id
, wg_filter_id
, wug_id)
SELECT
	mandant_id
	, wg_id
	, arthiertyp_id
	, 29 as wg_filter_id
        , -1 as wug_id
FROM DBP_DATA.wg_per
WHERE mandant_id > 1
AND wg_id in (122,128,183,184,146,147,186,185,282,283,284,285,286,288,289,293,294,148)
AND arthiertyp_id = 2
AND dat_bis= to_date('9999-12-31','YYYY-MM-DD')
;

INSERT INTO DBP_DATA.wg_filter_zu
( mandant_id
, wg_id
, arthiertyp_id
, wg_filter_id
, wug_id)
SELECT
	mandant_id
	, wg_id
	, arthiertyp_id
	, 30 as wg_filter_id
        , -1 as wug_id
FROM DBP_DATA.wg_per
WHERE abt_id in (8)
AND arthiertyp_id = 2
AND dat_bis= to_date('9999-12-31','YYYY-MM-DD')
;

INSERT INTO DBP_DATA.wg_filter_zu
( mandant_id
, wg_id
, arthiertyp_id
, wg_filter_id
, wug_id)
SELECT
	mandant_id
	, wg_id
	, arthiertyp_id
	, 31 as wg_filter_id
        , -1 as wug_id
FROM DBP_DATA.wg_per
WHERE wg_id in (534,535,536,537,538,539,541,542,543,544,545,546,547,548,549,551,552,553,554,555,556,557,558,559,561,562,563,564,565,566,567,568,569,571,572,573,574,575,576,577,578,579,581,582,583,584,658,662,663,664,665)
AND arthiertyp_id = 2
AND dat_bis= to_date('9999-12-31','YYYY-MM-DD')
;

INSERT INTO DBP_DATA.wg_filter_zu
( mandant_id
, wg_id
, arthiertyp_id
, wg_filter_id
, wug_id)
SELECT
	mandant_id
	, wg_id
	, arthiertyp_id
	, 32 as wg_filter_id
        , -1 as wug_id
FROM DBP_DATA.wg_per
WHERE abt_id = 8
AND arthiertyp_id = 2
AND dat_bis= to_date('9999-12-31','YYYY-MM-DD')
;

INSERT INTO DBP_DATA.wg_filter_zu
( mandant_id
, wg_id
, arthiertyp_id
, wg_filter_id
, wug_id)
SELECT
	mandant_id
	, wg_id
	, arthiertyp_id
	, 33 as wg_filter_id
        , -1 as wug_id
FROM DBP_DATA.wg_per
WHERE wg_id BETWEEN 960 AND 968
AND arthiertyp_id = 2
AND dat_bis= to_date('9999-12-31','YYYY-MM-DD')
;

INSERT INTO DBP_DATA.wg_filter_zu
( mandant_id
, wg_id
, arthiertyp_id
, wg_filter_id
, wug_id)
SELECT
	mandant_id
	, wg_id
	, arthiertyp_id
	, 34 as wg_filter_id
        , -1 as wug_id
FROM DBP_DATA.wg_per
WHERE wg_id BETWEEN 970 AND 979
AND arthiertyp_id = 2
AND dat_bis= to_date('9999-12-31','YYYY-MM-DD')
;

INSERT INTO DBP_DATA.wg_filter_zu
( mandant_id
, wg_id
, arthiertyp_id
, wg_filter_id
, wug_id)
SELECT
	mandant_id
	, wg_id
	, arthiertyp_id
	, 35 as wg_filter_id
        , -1 as wug_id
FROM DBP_DATA.wg_per
WHERE wg_id IN (818,969)
AND arthiertyp_id = 2
AND dat_bis= to_date('9999-12-31','YYYY-MM-DD')
;

INSERT INTO DBP_DATA.wg_filter_zu
( mandant_id
, wg_id
, arthiertyp_id
, wg_filter_id
, wug_id)
SELECT
	mandant_id
	, wg_id
	, arthiertyp_id
	, 36 as wg_filter_id
        , -1 as wug_id
FROM DBP_DATA.wg_per
WHERE abt_id in (5)
AND arthiertyp_id = 2
AND dat_bis= to_date('9999-12-31','YYYY-MM-DD')
;

INSERT INTO DBP_DATA.wg_filter_zu
( mandant_id
, wg_id
, arthiertyp_id
, wg_filter_id
, wug_id)
SELECT
	mandant_id
	, wg_id
	, arthiertyp_id
	, 37 as wg_filter_id
        , -1 as wug_id
FROM DBP_DATA.wg_per
WHERE wg_id in (122,128,129,131,132,133,134,135,136,137,138,139,141,142,143,144,145,146,147,148,149,152,153,154,155,156,157,158,159,161,162,163,164,179,181,182,183,184,185,186,187,232,233,234,235,236,237,238,
239,242,243,244,245,246,299,302,303,304,305,306,307,308,309,311,312,315,316,317,318,319,321,322,323,324,325,326,327,331,329,188,247,248,249,251,252,253,254,255,256,267,258,259 )
AND arthiertyp_id = 2
AND dat_bis= to_date('9999-12-31','YYYY-MM-DD')
;

INSERT INTO DBP_DATA.wg_filter_zu
( mandant_id
, wg_id
, arthiertyp_id
, wg_filter_id
, wug_id)
SELECT
	mandant_id
	, wg_id
	, arthiertyp_id
	, 38 as wg_filter_id
        , -1 as wug_id
FROM DBP_DATA.wg_per
WHERE wg_id IN (818,969)
AND arthiertyp_id = 2
AND dat_bis= to_date('9999-12-31','YYYY-MM-DD')
;

INSERT INTO DBP_DATA.wg_filter_zu
( mandant_id
, wg_id
, arthiertyp_id
, wg_filter_id
, wug_id)
SELECT
	mandant_id
	, wg_id
	, arthiertyp_id
	, 39 as wg_filter_id
        , -1 as wug_id
FROM DBP_DATA.wg_per
WHERE wg_id IN (980,981)
AND arthiertyp_id = 2
AND dat_bis= to_date('9999-12-31','YYYY-MM-DD')
;

INSERT INTO DBP_DATA.wg_filter_zu
( mandant_id
, wg_id
, arthiertyp_id
, wg_filter_id
, wug_id)
SELECT
	mandant_id
	, wg_id
	, arthiertyp_id
	, 40 as wg_filter_id
        , -1 as wug_id
FROM DBP_DATA.wg_per
WHERE owg_id IN (1091)
AND arthiertyp_id = 2
AND dat_bis= to_date('9999-12-31','YYYY-MM-DD')
AND wg_id = 823
AND mandant_id = 1
;

INSERT INTO DBP_DATA.wg_filter_zu
( mandant_id
, wg_id
, arthiertyp_id
, wg_filter_id
, wug_id)
SELECT
	mandant_id
	, wg_id
	, arthiertyp_id
	, 40 as wg_filter_id
        , 1 as wug_id
FROM DBP_DATA.wg_per
WHERE owg_id IN (1091)
AND arthiertyp_id = 2
AND dat_bis= to_date('9999-12-31','YYYY-MM-DD')
AND wg_id = 823
;

 INSERT INTO DBP_DATA.wg_filter_zu
( mandant_id
, wg_id
, arthiertyp_id
, wg_filter_id
, wug_id)
SELECT
	mandant_id
	, wg_id
	, arthiertyp_id
	, 40 as wg_filter_id
        , 999 as wug_id
FROM DBP_DATA.wg_per
WHERE owg_id IN (1091)
AND arthiertyp_id = 2
AND dat_bis= to_date('9999-12-31','YYYY-MM-DD')
AND wg_id = 823
;

INSERT INTO DBP_DATA.wg_filter_zu
( mandant_id
, wg_id
, arthiertyp_id
, wg_filter_id
, wug_id)
SELECT
	mandant_id
	, wg_id
	, arthiertyp_id
	, 43 as wg_filter_id
        , -1 as wug_id
FROM DBP_DATA.wg_per
WHERE wg_id IN (402, 403, 404, 405, 406, 407, 408, 409, 411, 412, 413, 414, 415, 416, 417, 418, 419, 421, 422, 423, 424, 425, 
                     426, 427, 428, 429, 431, 432, 433, 434, 435, 436, 437, 438, 439, 441, 442, 443, 444, 445, 446, 447, 448, 449,
		     452, 453, 454, 455, 456, 457, 458, 459, 461, 462, 463, 464, 465, 466, 467, 468, 469, 471, 473, 474, 475, 476, 
                     477, 478, 479, 481, 482, 483, 484, 485, 486, 487, 488, 489, 491, 492, 493, 494, 495, 496, 497, 498, 499, 501, 
                     502, 503, 504, 505, 506, 507, 508, 509, 511, 512, 513, 514, 515, 516, 517, 518, 519, 521, 522, 523, 524, 525, 
                     526, 527, 528, 529, 531, 532, 533, 534, 535, 536, 537, 538, 539, 541, 542, 543, 544, 545, 546, 547, 548, 549, 
                     551, 552, 553, 554, 662, 555, 663, 556, 664, 557, 558, 665, 559, 561, 562, 563, 564, 565, 566, 567, 568, 569, 
                     571, 572, 573, 574, 575, 576, 577, 578, 579, 581, 582, 583, 584, 585, 586, 587, 588, 589, 591, 592, 593, 594, 
                     595, 596, 597, 598, 599, 601, 602, 603, 604, 605, 606, 607, 608, 609, 612, 613, 614, 615, 616, 617, 618, 619, 
                     622, 623, 624, 625, 626, 627, 628, 629, 631, 632, 633, 634, 635, 636, 637, 638, 639, 644, 645, 646, 647, 648, 
                     649, 651, 652, 653, 654, 655, 656, 657, 658, 659, 661)
AND arthiertyp_id = 2
AND dat_bis= to_date('9999-12-31','YYYY-MM-DD')
;

INSERT INTO DBP_DATA.wg_filter_zu
( mandant_id
, wg_id
, arthiertyp_id
, wg_filter_id
, wug_id)
SELECT
	mandant_id
	, wg_id
	, arthiertyp_id
	, 44 as wg_filter_id
        , -1 as wug_id
FROM DBP_DATA.wg_per
WHERE wg_id IN (534,535,536,537,538,539,541,542,543,544,545,546,547,548,549,551,552,553,554,555,556,557,558,658,662,663,664,665,576,577,578,579,581,582,583,584)
AND arthiertyp_id = 2
AND dat_bis= to_date('9999-12-31','YYYY-MM-DD')
;

INSERT INTO DBP_DATA.wg_filter_zu
( mandant_id
, wg_id
, arthiertyp_id
, wg_filter_id
, wug_id)
SELECT
	mandant_id
	, wg_id
	, arthiertyp_id
	, 45 as wg_filter_id
        , -1 as wug_id
FROM DBP_DATA.wg_per
WHERE wg_id IN (523,524,525,526)
AND arthiertyp_id = 2
AND dat_bis= to_date('9999-12-31','YYYY-MM-DD')
;

INSERT INTO DBP_DATA.wg_filter_zu
( mandant_id
, wg_id
, arthiertyp_id
, wg_filter_id
, wug_id)
SELECT
	mandant_id
	, wg_id
	, arthiertyp_id
	, 46 as wg_filter_id
        , -1 as wug_id
FROM DBP_DATA.wg_per
WHERE wg_id IN (158,188,159)
AND arthiertyp_id = 2
AND dat_bis= to_date('9999-12-31','YYYY-MM-DD')
;

INSERT INTO DBP_DATA.wg_filter_zu
( mandant_id
, wg_id
, arthiertyp_id
, wg_filter_id
, wug_id)
SELECT
	mandant_id
	, wg_id
	, '2'
	, 47 as wg_filter_id
        , -1 as wug_id
FROM DBP_DATA.wg_per
WHERE wg_id in (232, 233, 234, 235, 236, 237, 238, 239, 242, 243, 244, 245, 246, 247, 248, 249, 251, 252, 253, 
                254, 255, 256, 257, 258, 259, 261, 262, 263, 264, 265, 266, 267, 268, 269, 272, 273, 274, 275, 
                276, 277, 278, 279, 281, 282, 283, 284, 285, 286, 288, 289, 293, 294, 295, 296, 297, 298, 299, 
                302, 303, 304, 305, 306, 307, 308, 309, 311, 312, 313, 314, 315, 316, 317, 318, 319, 321, 322, 
                323, 324, 325, 326, 327, 328, 331, 402, 403, 404, 405, 406, 407, 408, 409, 411, 412, 413, 414, 
                415, 416, 417, 418, 419, 421, 422, 423, 424, 425, 426, 427, 428, 429, 431, 432, 433, 434, 435, 
                436, 437, 438, 439, 441, 442, 443, 444, 445, 446, 447, 448, 449, 452, 453, 454, 455, 456, 457, 
                458, 459, 461, 462, 463, 464, 465, 466, 467, 468, 469, 471, 473, 474, 475, 476, 477, 478, 481, 
                482, 483, 484, 485, 486, 487, 488, 489, 491, 492, 493, 494, 495, 496, 497, 498, 499, 501, 502, 
                503, 504, 505, 506, 507, 508, 509, 511, 512, 513, 514, 515, 516, 517, 518, 519, 521, 522, 523, 
                524, 525, 526, 527, 528, 529, 531, 532, 533, 534, 535, 536, 537, 538, 539, 541, 542, 543, 544, 
                545, 546, 547, 548, 549, 551, 552, 553, 554, 555, 556, 557, 558, 559, 561, 562, 563, 564, 565, 
                566, 567, 568, 569, 571, 572, 573, 574, 575, 576, 577, 578, 579, 581, 582, 583, 584, 585, 586, 
                587, 588, 589, 591, 592, 593, 594, 595, 596, 597, 598, 599, 601, 602, 603, 604, 605, 606, 607, 
                608, 609, 612, 613, 614, 615, 616, 617, 618, 619, 622, 623, 624, 625, 626, 627, 628, 629, 631, 
                632, 633, 634, 635, 636, 637, 638, 639, 644, 645, 646, 647, 648, 649, 651, 652, 653, 654, 655, 
                656, 657, 658, 659, 661, 662, 663, 664, 665)
AND mandant_id > 1
AND arthiertyp_id = 2
AND dat_bis= to_date('9999-12-31','YYYY-MM-DD')
;

--SPEC0152305

INSERT INTO  DBP_DATA.l_wg_filter ( wg_filter_id, kommentar) VALUES (48, 'mandant_id in (2,6) and wg_id in (315,316,317,318,319,322)');

INSERT INTO  DBP_DATA.wg_filter_spr_zu ( wg_filter_id, spr_id, wg_filter_bez) VALUES (48, 22, 'Kollimengen LIPS aus BME berechnen (WG Eier + Fertig-Brötchen CZ+HR)');

INSERT INTO DBP_DATA.wg_filter_zu ( mandant_id, wg_id, arthiertyp_id, wg_filter_id, wug_id) values (2,315,'2',48,-1);
INSERT INTO DBP_DATA.wg_filter_zu ( mandant_id, wg_id, arthiertyp_id, wg_filter_id, wug_id) values (2,316,'2',48,-1);
INSERT INTO DBP_DATA.wg_filter_zu ( mandant_id, wg_id, arthiertyp_id, wg_filter_id, wug_id) values (2,317,'2',48,-1);
INSERT INTO DBP_DATA.wg_filter_zu ( mandant_id, wg_id, arthiertyp_id, wg_filter_id, wug_id) values (2,318,'2',48,-1);
INSERT INTO DBP_DATA.wg_filter_zu ( mandant_id, wg_id, arthiertyp_id, wg_filter_id, wug_id) values (2,319,'2',48,-1);
INSERT INTO DBP_DATA.wg_filter_zu ( mandant_id, wg_id, arthiertyp_id, wg_filter_id, wug_id) values (2,322,'2',48,-1);
INSERT INTO DBP_DATA.wg_filter_zu ( mandant_id, wg_id, arthiertyp_id, wg_filter_id, wug_id) values (6,315,'2',48,-1);
INSERT INTO DBP_DATA.wg_filter_zu ( mandant_id, wg_id, arthiertyp_id, wg_filter_id, wug_id) values (6,316,'2',48,-1);
INSERT INTO DBP_DATA.wg_filter_zu ( mandant_id, wg_id, arthiertyp_id, wg_filter_id, wug_id) values (6,317,'2',48,-1);
INSERT INTO DBP_DATA.wg_filter_zu ( mandant_id, wg_id, arthiertyp_id, wg_filter_id, wug_id) values (6,318,'2',48,-1);
INSERT INTO DBP_DATA.wg_filter_zu ( mandant_id, wg_id, arthiertyp_id, wg_filter_id, wug_id) values (6,319,'2',48,-1);
INSERT INTO DBP_DATA.wg_filter_zu ( mandant_id, wg_id, arthiertyp_id, wg_filter_id, wug_id) values (6,322,'2',48,-1);

--SPEC0152305 END

--Alex Wolter, VIS-Filter (24.07.2023), Start

INSERT INTO  DBP_DATA.l_wg_filter ( wg_filter_id, kommentar) VALUES (49, 'mandant_id in (1,2,3,4,5,6,7,8) and wg_id in (961,962)');

INSERT INTO  DBP_DATA.wg_filter_spr_zu ( wg_filter_id, spr_id, wg_filter_bez) VALUES (49, 22, 'Telefonkarten');

INSERT INTO DBP_DATA.wg_filter_zu ( mandant_id, wg_id, arthiertyp_id, wg_filter_id, wug_id) values (1,961,'2',49,-1);
INSERT INTO DBP_DATA.wg_filter_zu ( mandant_id, wg_id, arthiertyp_id, wg_filter_id, wug_id) values (2,961,'2',49,-1);
INSERT INTO DBP_DATA.wg_filter_zu ( mandant_id, wg_id, arthiertyp_id, wg_filter_id, wug_id) values (3,961,'2',49,-1);
INSERT INTO DBP_DATA.wg_filter_zu ( mandant_id, wg_id, arthiertyp_id, wg_filter_id, wug_id) values (4,961,'2',49,-1);
INSERT INTO DBP_DATA.wg_filter_zu ( mandant_id, wg_id, arthiertyp_id, wg_filter_id, wug_id) values (5,961,'2',49,-1);
INSERT INTO DBP_DATA.wg_filter_zu ( mandant_id, wg_id, arthiertyp_id, wg_filter_id, wug_id) values (6,961,'2',49,-1);
INSERT INTO DBP_DATA.wg_filter_zu ( mandant_id, wg_id, arthiertyp_id, wg_filter_id, wug_id) values (7,961,'2',49,-1);
INSERT INTO DBP_DATA.wg_filter_zu ( mandant_id, wg_id, arthiertyp_id, wg_filter_id, wug_id) values (8,961,'2',49,-1);

INSERT INTO DBP_DATA.wg_filter_zu ( mandant_id, wg_id, arthiertyp_id, wg_filter_id, wug_id) values (1,962,'2',49,-1);
INSERT INTO DBP_DATA.wg_filter_zu ( mandant_id, wg_id, arthiertyp_id, wg_filter_id, wug_id) values (2,962,'2',49,-1);
INSERT INTO DBP_DATA.wg_filter_zu ( mandant_id, wg_id, arthiertyp_id, wg_filter_id, wug_id) values (3,962,'2',49,-1);
INSERT INTO DBP_DATA.wg_filter_zu ( mandant_id, wg_id, arthiertyp_id, wg_filter_id, wug_id) values (4,962,'2',49,-1);
INSERT INTO DBP_DATA.wg_filter_zu ( mandant_id, wg_id, arthiertyp_id, wg_filter_id, wug_id) values (5,962,'2',49,-1);
INSERT INTO DBP_DATA.wg_filter_zu ( mandant_id, wg_id, arthiertyp_id, wg_filter_id, wug_id) values (6,962,'2',49,-1);
INSERT INTO DBP_DATA.wg_filter_zu ( mandant_id, wg_id, arthiertyp_id, wg_filter_id, wug_id) values (7,962,'2',49,-1);
INSERT INTO DBP_DATA.wg_filter_zu ( mandant_id, wg_id, arthiertyp_id, wg_filter_id, wug_id) values (8,962,'2',49,-1);

--Alex Wolter, VIS-Filter (24.07.2023), Ende

--Nic Wagner, AVQ-Filter (15.08.2023), Start

    --Doppelzuordnung WG 183 entfernen
DELETE FROM dbp_data.wg_filter_zu WHERE wg_filter_id in (27,28);

    --Neue Bez. + neuer Filter 50
DELETE FROM dbp_data.wg_filter_spr_zu WHERE WG_FILTER_ID in (27,28);
INSERT INTO dbp_data.wg_filter_spr_zu VALUES (27,22, 'AVQ (DE/KMO) WE 3 Tage vor Werbebeginn', NULL, NULL);
INSERT INTO dbp_data.wg_filter_spr_zu VALUES (28,22, 'AVQ (DE/KMO) WE 1 Tag vor Werbebeginn', NULL, NULL);
INSERT INTO dbp_data.wg_filter_spr_zu VALUES (50,22, 'AVQ (DE/KMO) WE am 1. Werbetag', NULL, NULL);

    --neuer Filter 50
INSERT INTO dbp_data.wg_filter_zu SELECT mandant_id, wg_id, arthiertyp_id, 50 as wg_filter_id, -1 as wug_id, null, null FROM dbp_data.wg_per where wg_id in (161,163,164,201,202,203,204,205,206,207,208,209,211,212,213,214,215,216,217) and dat_bis = '9999-12-31' and arthiertyp_id = 2;

    --zus. Mandanten 27
INSERT INTO dbp_data.wg_filter_zu SELECT mandant_id, wg_id, arthiertyp_id, 27 as wg_filter_id, -1 as wug_id, null, null FROM dbp_data.wg_per where wg_id in (134,135,136,137,138,139,141,142,143,144,145,179,181,182,187) and dat_bis = '9999-12-31' and arthiertyp_id = 2;

    --zus. Mandanten 28
INSERT INTO dbp_data.wg_filter_zu SELECT mandant_id, wg_id, arthiertyp_id, 28 as wg_filter_id, -1 as wug_id, null, null FROM dbp_data.wg_per where wg_id in (122,128,146,147,148,162,183,184,185,186,191,192) and dat_bis = '9999-12-31' and arthiertyp_id = 2;

--Nic Wagner, AVQ-Filter (15.08.2023), Ende


--new Sortimentstool filter
INSERT INTO dbp_data.wg_filter_zu(MANDANT_ID,WG_ID,ARTHIERTYP_ID,WG_FILTER_ID,WUG_ID,TD_UPDATE,TD_INSERT)
VALUES 
 (1,191,2,11,-1,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP)
,(1,218,2,11,-1,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP)
,(2,191,2,47,-1,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP)
,(2,218,2,47,-1,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP)
,(3,191,2,47,-1,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP)
,(3,218,2,47,-1,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP)
,(5,191,2,47,-1,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP)
,(5,218,2,47,-1,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP)
,(6,191,2,47,-1,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP)
,(6,218,2,47,-1,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP)
,(7,191,2,47,-1,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP)
,(7,218,2,47,-1,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP)
,(8,191,2,47,-1,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP)
,(8,218,2,47,-1,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP)
,(2,191,2,11,-1,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP)
,(2,218,2,11,-1,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP)
,(3,191,2,11,-1,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP)
,(3,218,2,11,-1,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP)
,(5,191,2,11,-1,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP)
,(5,218,2,11,-1,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP)
,(6,191,2,11,-1,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP)
,(6,218,2,11,-1,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP)
,(7,191,2,11,-1,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP)
,(7,218,2,11,-1,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP)
,(8,191,2,11,-1,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP)
,(8,218,2,11,-1,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP)
;

-- Nic Wagner, Autodispo (15.05.2025)
INSERT INTO dbp_data.wg_filter_spr_zu VALUES (51,22, 'Fleisch Autodispo', NULL, NULL);
INSERT INTO dbp_data.wg_filter_zu values (1,146,2,51,-1, current_timestamp,current_timestamp);
INSERT INTO dbp_data.wg_filter_zu values (1,147,2,51,-1, current_timestamp,current_timestamp);
INSERT INTO dbp_data.wg_filter_zu values (1,186,2,51,-1, current_timestamp,current_timestamp);
INSERT INTO dbp_data.wg_filter_zu values (1,192,2,51,-1, current_timestamp,current_timestamp);
