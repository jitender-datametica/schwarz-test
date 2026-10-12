TRUNCATE TABLE dbp_data.l_wg_filter;


TRUNCATE TABLE dbp_data.wg_filter_spr_zu;


TRUNCATE TABLE dbp_data.wg_filter_zu;


INSERT INTO dbp_data.l_wg_filter (wg_filter_id, kommentar, td_insert, td_update)
VALUES (1, 'Abteilung A06,A07', NULL, NULL);


INSERT INTO dbp_data.wg_filter_spr_zu (wg_filter_id, spr_id, wg_filter_bez, td_insert, td_update)
VALUES (1, 22, 'Bevorratung', NULL, NULL);


INSERT INTO dbp_data.l_wg_filter (wg_filter_id, kommentar, td_insert, td_update)
VALUES (2, 'OWG 1013/1014', NULL, NULL);


INSERT INTO dbp_data.wg_filter_spr_zu (wg_filter_id, spr_id, wg_filter_bez, td_insert, td_update)
VALUES (2, 22, 'Lebend-Blumen/-Pflan', NULL, NULL);


INSERT INTO dbp_data.l_wg_filter (wg_filter_id, kommentar, td_insert, td_update)
VALUES (3, 'OWG 1008 Backshop', NULL, NULL);


INSERT INTO dbp_data.wg_filter_spr_zu (wg_filter_id, spr_id, wg_filter_bez, td_insert, td_update)
VALUES (3, 22, 'Backshop', NULL, NULL);


INSERT INTO dbp_data.l_wg_filter (wg_filter_id, kommentar, td_insert, td_update)
VALUES (4, 'wg_id  between 980 and 989', NULL, NULL);


INSERT INTO dbp_data.wg_filter_spr_zu (wg_filter_id, spr_id, wg_filter_bez, td_insert, td_update)
VALUES (4, 22, 'Pfand, Cross-Docking, Ladungsträger', NULL, NULL);


INSERT INTO dbp_data.l_wg_filter (wg_filter_id, kommentar, td_insert, td_update)
VALUES (5, 'wg_id  = 980', NULL, NULL);


INSERT INTO dbp_data.wg_filter_spr_zu (wg_filter_id, spr_id, wg_filter_bez, td_insert, td_update)
VALUES (5, 22, 'Pfand', NULL, NULL);


INSERT INTO dbp_data.l_wg_filter (wg_filter_id, kommentar, td_insert, td_update)
VALUES (6, 'OWG 1013, 1014, 1010, 1011, 1012', NULL, NULL);


INSERT INTO dbp_data.wg_filter_spr_zu (wg_filter_id, spr_id, wg_filter_bez, td_insert, td_update)
VALUES (6, 22, 'Frisch-Obst/-Gemüse, Lebend-Blumen/-Pflan', NULL, NULL);


INSERT INTO dbp_data.l_wg_filter (wg_filter_id, kommentar, td_insert, td_update)
VALUES (
    7,
    'wg_id NOT IN (122,128,129,131,132,133,148,149,152,153,154,155,156,157,159,168,169,172,173,174,...,659,662,663,664,665,818,950,960,980,981,982,983,183,158,277,179,181,182)',
    NULL, NULL
);


INSERT INTO dbp_data.wg_filter_spr_zu (wg_filter_id, spr_id, wg_filter_bez, td_insert, td_update)
VALUES (
    7, 22, '$dbp_data.mk_art_wup_auswahl WG-Filter -- Ausschluss bestimmter Warengruppen aus der Abteilung Food',
    NULL, NULL
);


INSERT INTO dbp_data.l_wg_filter (wg_filter_id, kommentar, td_insert, td_update)
VALUES (
    8,
    'abt_id IN (5,6,7) and HWG not in (H64) bzw. wg_id in (122,128,129,131,132,133,134,135,136,137,138,139,141,142,143,144,145,146,147,148,...,655,656,657,658,659,661,662,663,664,665)',
    NULL, NULL
);


INSERT INTO dbp_data.wg_filter_spr_zu (wg_filter_id, spr_id, wg_filter_bez, td_insert, td_update)
VALUES (8, 22, 'Food Filter', NULL, NULL);


INSERT INTO dbp_data.l_wg_filter (wg_filter_id, kommentar, td_insert, td_update)
VALUES (9, 'wg_id IN (968)', NULL, NULL);


INSERT INTO dbp_data.wg_filter_spr_zu (wg_filter_id, spr_id, wg_filter_bez, td_insert, td_update)
VALUES (9, 22, 'Spenden', NULL, NULL);


INSERT INTO dbp_data.l_wg_filter (wg_filter_id, kommentar, td_insert, td_update)
VALUES (10, 'wg in (122,128,146,147,184,186)', NULL, NULL);


INSERT INTO dbp_data.wg_filter_spr_zu (wg_filter_id, spr_id, wg_filter_bez, td_insert, td_update)
VALUES (10, 22, 'Fleisch', NULL, NULL);


INSERT INTO dbp_data.l_wg_filter (wg_filter_id, kommentar, td_insert, td_update)
VALUES (
    11,
    'wg_id IN (232,233,234,235,236,237,238,239,242,243,244,245,246,247,248,249,251,252,253...591,592,593,594,595,596,597)',
    NULL, NULL
);


INSERT INTO dbp_data.wg_filter_spr_zu (wg_filter_id, spr_id, wg_filter_bez, td_insert, td_update)
VALUES (11, 22, 'Spezieller Filter für Sortimentstool', NULL, NULL);


INSERT INTO dbp_data.l_wg_filter (wg_filter_id, kommentar, td_insert, td_update)
VALUES (12, 'OWG in (1010,1011,1012)', NULL, NULL);


INSERT INTO dbp_data.wg_filter_spr_zu (wg_filter_id, spr_id, wg_filter_bez, td_insert, td_update)
VALUES (12, 22, 'Obst / Gemüse', NULL, NULL);


INSERT INTO dbp_data.l_wg_filter (wg_filter_id, kommentar, td_insert, td_update)
VALUES (13, 'OWG = 1026', NULL, NULL);


INSERT INTO dbp_data.wg_filter_spr_zu (wg_filter_id, spr_id, wg_filter_bez, td_insert, td_update)
VALUES (13, 22, 'Fehlmengen', NULL, NULL);


INSERT INTO dbp_data.l_wg_filter (wg_filter_id, kommentar, td_insert, td_update)
VALUES (14, 'wg_id IN (980,981,982,983,984,985)', NULL, NULL);


INSERT INTO dbp_data.wg_filter_spr_zu (wg_filter_id, spr_id, wg_filter_bez, td_insert, td_update)
VALUES (14, 22, 'Leergut', NULL, NULL);


INSERT INTO dbp_data.l_wg_filter (wg_filter_id, kommentar, td_insert, td_update)
VALUES (
    15,
    '(mandant_id = 1 AND wg_id IN (122,128,184,146,147,186)) OR (mandant_id = 2 AND wg_id IN( 768,782,783,784,785,786,787,791,792,797,825))',
    NULL, NULL
);


INSERT INTO dbp_data.wg_filter_spr_zu (wg_filter_id, spr_id, wg_filter_bez, td_insert, td_update)
VALUES (15, 22, 'Fleisch 2', NULL, NULL);


INSERT INTO dbp_data.l_wg_filter (wg_filter_id, kommentar, td_insert, td_update)
VALUES (16, 'wg_id <> 983', NULL, NULL);


INSERT INTO dbp_data.wg_filter_spr_zu (wg_filter_id, spr_id, wg_filter_bez, td_insert, td_update)
VALUES (16, 22, '/* WG <> 983 mögliche AKL Leerbehälter */', NULL, NULL);


INSERT INTO dbp_data.l_wg_filter (wg_filter_id, kommentar, td_insert, td_update)
VALUES (
    17,
    'wg_id NOT IN (122,128,183,184,146,147,186,161,162,163,164,18,148,321,322,323,324,325,326,327,149,152,153,154,155,156,157,282,283,284,285,286,288,289,293,294)',
    NULL, NULL
);


INSERT INTO dbp_data.wg_filter_spr_zu (wg_filter_id, spr_id, wg_filter_bez, td_insert, td_update)
VALUES (17, 22, '_wabi_man_bestellungen', NULL, NULL);


INSERT INTO dbp_data.l_wg_filter (wg_filter_id, kommentar, td_insert, td_update)
VALUES (
    18,
    'wg_id NOT IN (122,128,134,135,136,137,138,139,141,142,144,146,147,158,159,184,186,232,233,234,235,236,237,238,239,242,243,244,245,246,331,183,329,185,188)',
    NULL, NULL
);


INSERT INTO dbp_data.wg_filter_spr_zu (wg_filter_id, spr_id, wg_filter_bez, td_insert, td_update)
VALUES (18, 22, '_WGs fuer Ermittlung PM_ID', NULL, NULL);


INSERT INTO dbp_data.l_wg_filter (wg_filter_id, kommentar, td_insert, td_update)
VALUES (19, 'wg_id in (146,147,186)', NULL, NULL);


INSERT INTO dbp_data.wg_filter_spr_zu (wg_filter_id, spr_id, wg_filter_bez, td_insert, td_update)
VALUES (
    19, 22, 'Anreichern Aktionkennzeichen./Identifikation Artikel-Markt-Tag in Aktion analog zu AIS KMO.', NULL,
    NULL
);


INSERT INTO dbp_data.l_wg_filter (wg_filter_id, kommentar, td_insert, td_update)
VALUES (20, 'Bereich B02 - entspricht Abteilung 8 lt. A.Wolter', NULL, NULL);


INSERT INTO dbp_data.wg_filter_spr_zu (wg_filter_id, spr_id, wg_filter_bez, td_insert, td_update)
VALUES (20, 22, 'Nonfood', NULL, NULL);


INSERT INTO dbp_data.l_wg_filter (wg_filter_id, kommentar, td_insert, td_update)
VALUES (21, 'Bereich B02 - entspricht Abteilung 8 lt. A.Wolter', NULL, NULL);


INSERT INTO dbp_data.wg_filter_spr_zu (wg_filter_id, spr_id, wg_filter_bez, td_insert, td_update)
VALUES (21, 22, 'Ermittlung EK Mep 1', NULL, NULL);


INSERT INTO dbp_data.l_wg_filter (wg_filter_id, kommentar, td_insert, td_update)
VALUES (22, 'Bereich B02 - entspricht Abteilung 8 lt. A.Wolter', NULL, NULL);


INSERT INTO dbp_data.wg_filter_spr_zu (wg_filter_id, spr_id, wg_filter_bez, td_insert, td_update)
VALUES (22, 22, 'Ermittlung EK Mep 2', NULL, NULL);


INSERT INTO dbp_data.l_wg_filter (wg_filter_id, kommentar, td_insert, td_update)
VALUES (23, 'wg_id in (122,128,146,147,184,186) and mandant_id in (1,2)', NULL, NULL);


INSERT INTO dbp_data.wg_filter_spr_zu (wg_filter_id, spr_id, wg_filter_bez, td_insert, td_update)
VALUES (23, 22, 'EKPO flw_fg', NULL, NULL);


INSERT INTO dbp_data.l_wg_filter (wg_filter_id, kommentar, td_insert, td_update)
VALUES (
    24,
    'mandant_id = 1 AND wg_id IN (797,798,799,823,829,805,806,824,808,812,813,794,811,822,772,773,774,809,804,807,825,819)',
    NULL, NULL
);


INSERT INTO dbp_data.wg_filter_spr_zu (wg_filter_id, spr_id, wg_filter_bez, td_insert, td_update)
VALUES (24, 22, 'NPD-Group Export', NULL, NULL);


INSERT INTO dbp_data.l_wg_filter (wg_filter_id, kommentar, td_insert, td_update)
VALUES (
    25,
    'mandant_id = 1 AND wg_id NOT IN (122,128,184,146,147,186,134,135,...,149,152,153,154,155,156,157,179,181,182,148)',
    NULL, NULL
);


INSERT INTO dbp_data.wg_filter_spr_zu (wg_filter_id, spr_id, wg_filter_bez, td_insert, td_update)
VALUES (25, 22, 'AVQ (DE) Bestellartenausschluss', NULL, NULL);


INSERT INTO dbp_data.l_wg_filter (wg_filter_id, kommentar, td_insert, td_update)
VALUES (
    26,
    'mandant_id > 1 AND wg_id NOT IN (122,128,184,146,147,186,183,185,161,162,163,164,282,283,284,285,...152,153,154,155,156,157,179,181,182,148)',
    NULL, NULL
);


INSERT INTO dbp_data.wg_filter_spr_zu (wg_filter_id, spr_id, wg_filter_bez, td_insert, td_update)
VALUES (26, 22, 'AVQ (KMO) Bestellartenausschluss', NULL, NULL);


INSERT INTO dbp_data.l_wg_filter (wg_filter_id, kommentar, td_insert, td_update)
VALUES (27, 'mandant_id = 1 AND wg_id IN (134,135,136,137,138,139,141,142,144,183,143,145,187,179,181,182)', NULL, NULL
);


INSERT INTO dbp_data.wg_filter_spr_zu (wg_filter_id, spr_id, wg_filter_bez, td_insert, td_update)
VALUES (27, 22, 'AVQ (DE) 3 Tage vor Werbebeginn', NULL, NULL);


INSERT INTO dbp_data.l_wg_filter (wg_filter_id, kommentar, td_insert, td_update)
VALUES (28, 'mandant_id = 1 AND wg_id IN (122,128,183,184,146,147,186,185,148)', NULL, NULL);


INSERT INTO dbp_data.wg_filter_spr_zu (wg_filter_id, spr_id, wg_filter_bez, td_insert, td_update)
VALUES (28, 22, 'AVQ (DE) 1 Tag vor Werbebeginn', NULL, NULL);


INSERT INTO dbp_data.l_wg_filter (wg_filter_id, kommentar, td_insert, td_update)
VALUES (
    29, 'mandant_id > 1 AND wg_id IN (122,128,183,184,146,147,186,185,282,283,284,285,286,288,289,293,294,148)',
    NULL, NULL
);


INSERT INTO dbp_data.wg_filter_spr_zu (wg_filter_id, spr_id, wg_filter_bez, td_insert, td_update)
VALUES (29, 22, 'AVQ (KMO) 3 Tage vor Werbebeginn', NULL, NULL);


INSERT INTO dbp_data.l_wg_filter (wg_filter_id, kommentar, td_insert, td_update)
VALUES (30, 'abt_id IN (8)', NULL, NULL);


INSERT INTO dbp_data.wg_filter_spr_zu (wg_filter_id, spr_id, wg_filter_bez, td_insert, td_update)
VALUES (30, 22, 'AVQ (DE/KMO) Nonfood', NULL, NULL);


INSERT INTO dbp_data.l_wg_filter (wg_filter_id, kommentar, td_insert, td_update)
VALUES (
    31,
    'wg_id IN (534 ,535 ,536 ,537 ,538 ,539 ,541 ,542 ,543 ,544 ,545 ,546 ,547 ,548 ,549 ,...,584 ,658 ,662 ,663 ,664 ,665 )',
    NULL, NULL
);


INSERT INTO dbp_data.wg_filter_spr_zu (wg_filter_id, spr_id, wg_filter_bez, td_insert, td_update)
VALUES (31, 22, 'Getränke (Shopper)', NULL, NULL);


INSERT INTO dbp_data.l_wg_filter (wg_filter_id, kommentar, td_insert, td_update)
VALUES (32, 'Bereich B02 - entspricht Abteilung 8 lt. A.Wolter', NULL, NULL);


INSERT INTO dbp_data.wg_filter_spr_zu (wg_filter_id, spr_id, wg_filter_bez, td_insert, td_update)
VALUES (32, 22, 'Fremdsortiment 1 (ARTBEW)', NULL, NULL);


INSERT INTO dbp_data.l_wg_filter (wg_filter_id, kommentar, td_insert, td_update)
VALUES (33, 'wg_id BETWEEN 960 AND 968', NULL, NULL);


INSERT INTO dbp_data.wg_filter_spr_zu (wg_filter_id, spr_id, wg_filter_bez, td_insert, td_update)
VALUES (33, 22, 'Fremdsortiment 2 (ARTBEW)', NULL, NULL);


INSERT INTO dbp_data.l_wg_filter (wg_filter_id, kommentar, td_insert, td_update)
VALUES (34, 'wg_id BETWEEN 970 AND 979', NULL, NULL);


INSERT INTO dbp_data.wg_filter_spr_zu (wg_filter_id, spr_id, wg_filter_bez, td_insert, td_update)
VALUES (34, 22, 'Fremdsortiment 3 (ARTBEW)', NULL, NULL);


INSERT INTO dbp_data.l_wg_filter (wg_filter_id, kommentar, td_insert, td_update)
VALUES (35, 'wg_id IN (818,969)', NULL, NULL);


INSERT INTO dbp_data.wg_filter_spr_zu (wg_filter_id, spr_id, wg_filter_bez, td_insert, td_update)
VALUES (35, 22, 'MIS-Filter 1 (ARTBEW)', NULL, NULL);


INSERT INTO dbp_data.l_wg_filter (wg_filter_id, kommentar, td_insert, td_update)
VALUES (36, 'abt_id (5,6,7)', NULL, NULL);


INSERT INTO dbp_data.wg_filter_spr_zu (wg_filter_id, spr_id, wg_filter_bez, td_insert, td_update)
VALUES (36, 22, 'Bon Sergmente FIlter', NULL, NULL);


INSERT INTO dbp_data.l_wg_filter (wg_filter_id, kommentar, td_insert, td_update)
VALUES (
    37,
    'wg_id in (122,128,129,131,132,133,134,135,136,137,138,139,141,142,143,144,...,329,188,247,248,249,251,252,253,254,255,256,267,258,259)',
    NULL, NULL
);


INSERT INTO dbp_data.wg_filter_spr_zu (wg_filter_id, spr_id, wg_filter_bez, td_insert, td_update)
VALUES (37, 22, 'Bon Umsatz Brutto Filter', NULL, NULL);


INSERT INTO dbp_data.l_wg_filter (wg_filter_id, kommentar, td_insert, td_update)
VALUES (38, 'wg_id IN (818,969)', NULL, NULL);


INSERT INTO dbp_data.wg_filter_spr_zu (wg_filter_id, spr_id, wg_filter_bez, td_insert, td_update)
VALUES (38, 22, 'MIS-Telefonkarten (ARTBEW)', NULL, NULL);


INSERT INTO dbp_data.l_wg_filter (wg_filter_id, kommentar, td_insert, td_update)
VALUES (39, 'wg_id IN (980,981)', NULL, NULL);


INSERT INTO dbp_data.wg_filter_spr_zu (wg_filter_id, spr_id, wg_filter_bez, td_insert, td_update)
VALUES (39, 22, 'Kasse_pfand in BON', NULL, NULL);


INSERT INTO dbp_data.l_wg_filter (wg_filter_id, kommentar, td_insert, td_update)
VALUES (40, 'OWG 1091', NULL, NULL);


INSERT INTO dbp_data.wg_filter_spr_zu (wg_filter_id, spr_id, wg_filter_bez, td_insert, td_update)
VALUES (40, 22, 'Kasse_Tueten in BON', NULL, NULL);


INSERT INTO dbp_data.l_wg_filter (wg_filter_id, kommentar, td_insert, td_update)
VALUES (
    43,
    'wg_temp_id IN (402, 403, 404, 405, 406, 407, 408, 409, 411, 412, 413, 414  .....  653, 654, 655, 656, 657, 658, 659, 661)',
    NULL, NULL
);


INSERT INTO dbp_data.wg_filter_spr_zu (wg_filter_id, spr_id, wg_filter_bez, td_insert, td_update)
VALUES (43, 22, 'Sortimentstool KMO FB Definition für wg_temp)', NULL, NULL);


INSERT INTO dbp_data.l_wg_filter (wg_filter_id, kommentar, td_insert, td_update)
VALUES (44, 'wg_id IN (534,535,536,537,538,539,541,542,...,581,582,583,584 )', NULL, NULL);


INSERT INTO dbp_data.wg_filter_spr_zu (wg_filter_id, spr_id, wg_filter_bez, td_insert, td_update)
VALUES (44, 22, 'AVQ (DE) Bier/AFG', NULL, NULL);


INSERT INTO dbp_data.l_wg_filter (wg_filter_id, kommentar, td_insert, td_update)
VALUES (45, 'wg_id IN (523,524,525,526)', NULL, NULL);


INSERT INTO dbp_data.wg_filter_spr_zu (wg_filter_id, spr_id, wg_filter_bez, td_insert, td_update)
VALUES (45, 22, 'AVQ (DE/KMO) Sü\u00dfwaren', NULL, NULL);


INSERT INTO dbp_data.l_wg_filter (wg_filter_id, kommentar, td_insert, td_update)
VALUES (46, 'wg_id IN (158,188,159)', NULL, NULL);


INSERT INTO dbp_data.wg_filter_spr_zu (wg_filter_id, spr_id, wg_filter_bez, td_insert, td_update)
VALUES (46, 22, 'AVQ (KMO) Hei\u00dfe Theke/Grill', NULL, NULL);


INSERT INTO dbp_data.l_wg_filter (wg_filter_id, kommentar, td_insert, td_update)
VALUES (
    47,
    'wg_id IN (232, 233, 234, 235, 236, 237, 238, 239, 242, 243, 244 ..... 656, 657, 658, 659, 661, 662, 663, 664, 665)',
    NULL, NULL
);


INSERT INTO dbp_data.wg_filter_spr_zu (wg_filter_id, spr_id, wg_filter_bez, td_insert, td_update)
VALUES (47, 22, 'Sortimentstool KMO FB Definition)', NULL, NULL);


INSERT INTO dbp_data.wg_filter_zu (mandant_id, wg_id, arthiertyp_id, wg_filter_id, wug_id)
(
    SELECT
        mandant_id,
        wg_id,
        arthiertyp_id,
        1 AS wg_filter_id,
        -1 AS wug_id
    FROM dbp_data.wg_per
    WHERE
        abt_id IN (6, 7)
        AND arthiertyp_id = 2
        AND dat_bis = PARSE_DATE('%F', '9999-12-31')
);


INSERT INTO dbp_data.wg_filter_zu (mandant_id, wg_id, arthiertyp_id, wg_filter_id, wug_id)
(
    SELECT
        mandant_id,
        wg_id,
        arthiertyp_id,
        2 AS wg_filter_id,
        -1 AS wug_id
    FROM dbp_data.wg_per
    WHERE
        owg_id IN (1013, 1014)
        AND arthiertyp_id = 2
        AND dat_bis = PARSE_DATE('%F', '9999-12-31')
);


INSERT INTO dbp_data.wg_filter_zu (mandant_id, wg_id, arthiertyp_id, wg_filter_id, wug_id)
(
    SELECT
        mandant_id,
        wg_id,
        arthiertyp_id,
        3 AS wg_filter_id,
        -1 AS wug_id
    FROM dbp_data.wg_per
    WHERE
        owg_id IN (1008)
        AND arthiertyp_id = 2
        AND dat_bis = PARSE_DATE('%F', '9999-12-31')
);


INSERT INTO dbp_data.wg_filter_zu (mandant_id, wg_id, arthiertyp_id, wg_filter_id, wug_id)
(
    SELECT
        mandant_id,
        wg_id,
        arthiertyp_id,
        4 AS wg_filter_id,
        -1 AS wug_id
    FROM dbp_data.wg_per
    WHERE
        wg_id BETWEEN 980 AND 989
        AND arthiertyp_id = 2
        AND dat_bis = PARSE_DATE('%F', '9999-12-31')
);


INSERT INTO dbp_data.wg_filter_zu (mandant_id, wg_id, arthiertyp_id, wg_filter_id, wug_id)
(
    SELECT
        mandant_id,
        wg_id,
        arthiertyp_id,
        5 AS wg_filter_id,
        -1 AS wug_id
    FROM dbp_data.wg_per
    WHERE
        wg_id = 980
        AND arthiertyp_id = 2
        AND dat_bis = PARSE_DATE('%F', '9999-12-31')
);


INSERT INTO dbp_data.wg_filter_zu (mandant_id, wg_id, arthiertyp_id, wg_filter_id, wug_id)
(
    SELECT
        mandant_id,
        wg_id,
        arthiertyp_id,
        6 AS wg_filter_id,
        -1 AS wug_id
    FROM dbp_data.wg_per
    WHERE
        owg_id IN (1013, 1014, 1010, 1011, 1012)
        AND arthiertyp_id = 2
        AND dat_bis = PARSE_DATE('%F', '9999-12-31')
);


INSERT INTO dbp_data.wg_filter_zu (mandant_id, wg_id, arthiertyp_id, wg_filter_id, wug_id)
(SELECT
    mandant_id,
    wg_id,
    arthiertyp_id,
    7 AS wg_filter_id,
    -1 AS wug_id
FROM dbp_data.wg_per
WHERE wg_id IN (
    122, 128, 129, 131, 132, 133, 148, 149, 152, 153, 154, 155, 156, 157, 159, 168, 169, 172, 173, 174, 175,
    176, 177, 178, 184, 261, 262, 263, 268, 269, 272, 273, 274, 275, 276, 278, 279, 281, 328, 329, 523, 524, 525, 526,
    534, 535, 536, 537, 538, 539, 541, 542, 543, 544, 545, 546, 547, 548, 549, 551, 552, 553, 554, 555, 556, 557, 558,
    576, 577, 578, 579, 581, 582, 583, 584, 603, 604, 605, 658, 659, 662, 663, 664, 665, 818, 950, 960, 980, 981, 982,
    983, 183, 158, 277, 179, 181, 182
)
AND arthiertyp_id = 2
AND dat_bis = PARSE_DATE('%F', '9999-12-31'));


INSERT INTO dbp_data.wg_filter_zu (mandant_id, wg_id, arthiertyp_id, wg_filter_id, wug_id)
(SELECT
    mandant_id,
    wg_id,
    arthiertyp_id,
    8 AS wg_filter_id,
    -1 AS wug_id
FROM dbp_data.wg_per
WHERE wg_id IN (
    122, 128, 129, 131, 132, 133, 134, 135, 136, 137, 138, 139, 141, 142, 143, 144, 145, 146, 147, 148, 149,
    152, 153, 154, 155, 156, 157, 158, 159, 179, 181, 182, 183, 184, 185, 186, 187, 188, 232, 233, 234, 235, 236, 237,
    238, 239, 242, 243, 244, 245, 246, 247, 248, 249, 251, 252, 253, 254, 255, 256, 257, 258, 259, 261, 262, 263, 264,
    265, 266, 267, 268, 269, 272, 273, 274, 275, 276, 277, 278, 279, 281, 282, 283, 284, 285, 286, 288, 289, 293, 294,
    295, 296, 297, 298, 299, 302, 303, 304, 305, 306, 307, 308, 309, 311, 312, 313, 314, 315, 316, 317, 318, 319, 321,
    322, 323, 324, 325, 326, 327, 328, 329, 331, 402, 403, 404, 405, 406, 407, 408, 409, 411, 412, 413, 414, 415, 416,
    417, 418, 419, 421, 422, 423, 424, 425, 426, 427, 428, 429, 431, 432, 433, 434, 435, 436, 437, 438, 439, 441, 442,
    443, 444, 445, 446, 447, 448, 449, 452, 453, 454, 455, 456, 457, 458, 459, 461, 462, 463, 464, 465, 466, 467, 468,
    469, 471, 473, 474, 475, 476, 477, 478, 481, 482, 483, 484, 485, 486, 487, 488, 489, 491, 492, 493, 494, 495, 496,
    497, 498, 499, 501, 502, 503, 504, 505, 506, 507, 508, 509, 511, 512, 513, 514, 515, 516, 517, 518, 519, 521, 522,
    523, 524, 525, 526, 527, 528, 529, 531, 532, 533, 534, 535, 536, 537, 538, 539, 541, 542, 543, 544, 545, 546, 547,
    548, 549, 551, 552, 553, 554, 555, 556, 557, 558, 559, 561, 562, 563, 564, 565, 566, 567, 568, 569, 571, 572, 573,
    574, 575, 576, 577, 578, 579, 581, 582, 583, 584, 585, 586, 587, 588, 589, 591, 592, 593, 594, 595, 596, 597, 598,
    599, 601, 602, 603, 604, 605, 606, 607, 608, 609, 612, 613, 614, 615, 616, 617, 618, 619, 622, 623, 624, 625, 626,
    627, 628, 629, 631, 632, 633, 634, 635, 636, 637, 638, 639, 644, 645, 646, 647, 648, 649, 651, 652, 653, 654, 655,
    656, 657, 658, 659, 661, 662, 663, 664, 665
)
AND arthiertyp_id = 2
AND dat_bis = PARSE_DATE('%F', '9999-12-31'));


INSERT INTO dbp_data.wg_filter_zu (mandant_id, wg_id, arthiertyp_id, wg_filter_id, wug_id)
(
    SELECT
        mandant_id,
        wg_id,
        arthiertyp_id,
        9 AS wg_filter_id,
        -1 AS wug_id
    FROM dbp_data.wg_per
    WHERE
        wg_id IN (968)
        AND arthiertyp_id = 2
        AND dat_bis = PARSE_DATE('%F', '9999-12-31')
);


INSERT INTO dbp_data.wg_filter_zu (mandant_id, wg_id, arthiertyp_id, wg_filter_id, wug_id)
(
    SELECT
        mandant_id,
        wg_id,
        arthiertyp_id,
        10 AS wg_filter_id,
        -1 AS wug_id
    FROM dbp_data.wg_per
    WHERE
        wg_id IN (122, 128, 146, 147, 184, 186, 191, 192)
        AND arthiertyp_id = 2
        AND dat_bis = PARSE_DATE('%F', '9999-12-31')
);


INSERT INTO dbp_data.wg_filter_zu (mandant_id, wg_id, arthiertyp_id, wg_filter_id, wug_id)
(SELECT
    mandant_id,
    wg_id,
    arthiertyp_id,
    11 AS wg_filter_id,
    -1 AS wug_id
FROM dbp_data.wg_per
WHERE wg_id IN (
    232, 233, 234, 235, 236, 237, 238, 239, 242, 243, 244, 245, 246, 247, 248, 249, 251, 252, 253, 254, 255,
    256, 257, 258, 259, 261, 262, 263, 264, 265, 266, 267, 268, 269, 272, 273, 274, 275, 276, 277, 278, 279, 281, 282,
    283, 284, 285, 286, 288, 289, 293, 294, 295, 296, 297, 298, 299, 302, 303, 304, 305, 306, 307, 308, 309, 311, 312,
    313, 314, 315, 316, 317, 318, 319, 321, 322, 323, 324, 325, 326, 327, 328, 331, 402, 403, 404, 405, 406, 407, 408,
    409, 411, 412, 413, 414, 415, 416, 417, 418, 419, 421, 422, 423, 424, 425, 426, 427, 428, 429, 431, 432, 433, 434,
    435, 436, 437, 438, 439, 441, 442, 443, 444, 445, 446, 447, 448, 449, 452, 453, 454, 455, 456, 457, 458, 459, 461,
    462, 463, 464, 465, 466, 467, 468, 469, 471, 473, 474, 475, 476, 477, 478, 481, 482, 483, 484, 485, 486, 487, 488,
    489, 491, 492, 493, 494, 495, 496, 497, 498, 499, 501, 502, 503, 504, 505, 506, 507, 508, 509, 511, 512, 513, 514,
    515, 516, 517, 518, 519, 521, 522, 523, 524, 525, 526, 527, 528, 529, 531, 532, 533, 534, 535, 536, 537, 538, 539,
    541, 542, 543, 544, 545, 546, 547, 548, 549, 551, 552, 553, 554, 555, 556, 557, 558, 559, 561, 562, 563, 564, 565,
    566, 567, 568, 569, 571, 572, 573, 574, 575, 576, 577, 578, 579, 581, 582, 583, 584, 585, 586, 587, 588, 589, 591,
    592, 593, 594, 595, 596, 597, 598, 599, 601, 602, 603, 604, 605, 606, 607, 608, 609, 612, 613, 614, 615, 616, 617,
    618, 619, 622, 623, 624, 625, 626, 627, 628, 629, 631, 632, 633, 634, 635, 636, 637, 638, 639, 644, 645, 646, 647,
    648, 649, 651, 652, 653, 654, 655, 656, 657, 658, 659, 661, 662, 663, 664, 665, 122, 128, 129, 131, 132, 133, 134,
    135, 136, 137, 138, 139, 141, 142, 143, 144, 145, 179, 181, 182, 183, 184, 187, 329
)
AND arthiertyp_id = 2
AND dat_bis = PARSE_DATE('%F', '9999-12-31'));


INSERT INTO dbp_data.wg_filter_zu (mandant_id, wg_id, arthiertyp_id, wg_filter_id, wug_id)
(
    SELECT
        mandant_id,
        wg_id,
        arthiertyp_id,
        12 AS wg_filter_id,
        -1 AS wug_id
    FROM dbp_data.wg_per
    WHERE
        owg_id IN (1010, 1011, 1012)
        AND arthiertyp_id = 2
        AND dat_bis = PARSE_DATE('%F', '9999-12-31')
);


INSERT INTO dbp_data.wg_filter_zu (mandant_id, wg_id, arthiertyp_id, wg_filter_id, wug_id)
(
    SELECT
        mandant_id,
        wg_id,
        arthiertyp_id,
        13 AS wg_filter_id,
        -1 AS wug_id
    FROM dbp_data.wg_per
    WHERE
        owg_id IN (1026)
        AND arthiertyp_id = 2
        AND dat_bis = PARSE_DATE('%F', '9999-12-31')
);


INSERT INTO dbp_data.wg_filter_zu (mandant_id, wg_id, arthiertyp_id, wg_filter_id, wug_id)
(
    SELECT
        mandant_id,
        wg_id,
        arthiertyp_id,
        14 AS wg_filter_id,
        -1 AS wug_id
    FROM dbp_data.wg_per
    WHERE
        wg_id IN (980, 981, 982, 983, 984, 985)
        AND arthiertyp_id = 2
        AND dat_bis = PARSE_DATE('%F', '9999-12-31')
);


INSERT INTO dbp_data.wg_filter_zu (mandant_id, wg_id, arthiertyp_id, wg_filter_id, wug_id)
(
    SELECT
        mandant_id,
        wg_id,
        arthiertyp_id,
        15 AS wg_filter_id,
        -1 AS wug_id
    FROM dbp_data.wg_per
    WHERE
        mandant_id = 1 AND wg_id IN (122, 128, 184, 146, 147, 186, 191, 192)
        OR mandant_id = 2 AND wg_id IN (768, 782, 783, 784, 785, 786, 787, 791, 792, 797, 825) AND arthiertyp_id = 2 AND
        dat_bis = PARSE_DATE('%F', '9999-12-31')
);


INSERT INTO dbp_data.wg_filter_zu (mandant_id, wg_id, arthiertyp_id, wg_filter_id, wug_id)
(
    SELECT
        mandant_id,
        wg_id,
        arthiertyp_id,
        16 AS wg_filter_id,
        -1 AS wug_id
    FROM dbp_data.wg_per
    WHERE
        wg_id <> 983
        AND arthiertyp_id = 2
        AND dat_bis = PARSE_DATE('%F', '9999-12-31')
);


INSERT INTO dbp_data.wg_filter_zu (mandant_id, wg_id, arthiertyp_id, wg_filter_id, wug_id)
(SELECT
    mandant_id,
    wg_id,
    arthiertyp_id,
    17 AS wg_filter_id,
    -1 AS wug_id
FROM dbp_data.wg_per
WHERE wg_id IN (
    122, 128, 183, 184, 146, 147, 186, 161, 162, 163, 164, 185, 148, 321, 322, 323, 324, 325, 326, 327, 149,
    152, 153, 154, 155, 156, 157, 282, 283, 284, 285, 286, 288, 289, 293, 294
)
AND arthiertyp_id = 2
AND dat_bis = PARSE_DATE('%F', '9999-12-31'));


INSERT INTO dbp_data.wg_filter_zu (mandant_id, wg_id, arthiertyp_id, wg_filter_id, wug_id)
(SELECT
    mandant_id,
    wg_id,
    arthiertyp_id,
    18 AS wg_filter_id,
    -1 AS wug_id
FROM dbp_data.wg_per
WHERE wg_id IN (
    122, 128, 134, 135, 136, 137, 138, 139, 141, 142, 144, 146, 147, 158, 159, 184, 186, 232, 233, 234, 235,
    236, 237, 238, 239, 242, 243, 244, 245, 246, 331, 183, 329, 185, 188
)
AND arthiertyp_id = 2
AND dat_bis = PARSE_DATE('%F', '9999-12-31'));


INSERT INTO dbp_data.wg_filter_zu (mandant_id, wg_id, arthiertyp_id, wg_filter_id, wug_id)
(
    SELECT
        mandant_id,
        wg_id,
        arthiertyp_id,
        19 AS wg_filter_id,
        -1 AS wug_id
    FROM dbp_data.wg_per
    WHERE
        wg_id IN (146, 147, 186)
        AND arthiertyp_id = 2
        AND dat_bis = PARSE_DATE('%F', '9999-12-31')
);


INSERT INTO dbp_data.wg_filter_zu (mandant_id, wg_id, arthiertyp_id, wg_filter_id, wug_id)
(
    SELECT
        mandant_id,
        wg_id,
        arthiertyp_id,
        20 AS wg_filter_id,
        -1 AS wug_id
    FROM dbp_data.wg_per
    WHERE
        abt_id = 8
        AND arthiertyp_id = 2
        AND dat_bis = PARSE_DATE('%F', '9999-12-31')
);


INSERT INTO dbp_data.wg_filter_zu (mandant_id, wg_id, arthiertyp_id, wg_filter_id, wug_id)
(
    SELECT
        mandant_id,
        wg_id,
        arthiertyp_id,
        21 AS wg_filter_id,
        -1 AS wug_id
    FROM dbp_data.wg_per
    WHERE
        abt_id = 8
        AND arthiertyp_id = 2
        AND dat_bis = PARSE_DATE('%F', '9999-12-31')
);


INSERT INTO dbp_data.wg_filter_zu (mandant_id, wg_id, arthiertyp_id, wg_filter_id, wug_id)
(
    SELECT
        mandant_id,
        wg_id,
        arthiertyp_id,
        22 AS wg_filter_id,
        -1 AS wug_id
    FROM dbp_data.wg_per
    WHERE
        abt_id = 8
        AND arthiertyp_id = 2
        AND dat_bis = PARSE_DATE('%F', '9999-12-31')
);


INSERT INTO dbp_data.wg_filter_zu (mandant_id, wg_id, arthiertyp_id, wg_filter_id, wug_id)
(
    SELECT
        mandant_id,
        wg_id,
        arthiertyp_id,
        23 AS wg_filter_id,
        -1 AS wug_id
    FROM dbp_data.wg_per
    WHERE
        mandant_id IN (1, 2)
        AND wg_id IN (122, 128, 146, 147, 184, 186, 191, 192)
        AND arthiertyp_id = 2
        AND dat_bis = PARSE_DATE('%F', '9999-12-31')
);


INSERT INTO dbp_data.wg_filter_zu (mandant_id, wg_id, arthiertyp_id, wg_filter_id, wug_id)
(SELECT
    mandant_id,
    wg_id,
    arthiertyp_id,
    24 AS wg_filter_id,
    -1 AS wug_id
FROM dbp_data.wg_per
WHERE wg_id IN (
    797, 798, 799, 823, 829, 805, 806, 824, 808, 812, 813, 794, 811, 822, 772, 773, 774, 809, 804, 807, 825,
    819
)
AND arthiertyp_id = 2
AND dat_bis = PARSE_DATE('%F', '9999-12-31'));


INSERT INTO dbp_data.wg_filter_zu (mandant_id, wg_id, arthiertyp_id, wg_filter_id, wug_id)
(SELECT
    mandant_id,
    wg_id,
    arthiertyp_id,
    25 AS wg_filter_id,
    -1 AS wug_id
FROM dbp_data.wg_per
WHERE wg_id IN (
    122, 128, 184, 146, 147, 186, 134, 135, 136, 137, 138, 139, 141, 142, 144, 183, 185, 161, 162, 163, 164,
    165, 166, 143, 145, 187, 179, 181, 182, 148, 191, 192, 201, 202, 203, 204, 205, 206, 207, 208, 209, 211, 212, 213,
    214, 215, 216, 217
)
AND mandant_id = 1
AND arthiertyp_id = 2
AND dat_bis = PARSE_DATE('%F', '9999-12-31'));


INSERT INTO dbp_data.wg_filter_zu (mandant_id, wg_id, arthiertyp_id, wg_filter_id, wug_id)
(
    SELECT
        mandant_id,
        wg_id,
        arthiertyp_id,
        26 AS wg_filter_id,
        -1 AS wug_id
    FROM dbp_data.wg_per
    WHERE
        mandant_id > 1
        AND wg_id IN (
            122, 128, 184, 146, 147, 186, 183, 185, 161, 162, 163, 164, 165, 166, 282, 283, 284, 285, 286, 288, 289,
            293, 294, 143, 145, 187, 321, 322, 323, 324, 325, 326, 327, 149, 152, 153, 154, 155, 156, 157, 179, 181, 182, 148,
            191, 192, 201, 202, 203, 204, 205, 206, 207, 208, 209, 211, 212, 213, 214, 215, 216, 217
        )
        AND arthiertyp_id = 2
        AND dat_bis = PARSE_DATE('%F', '9999-12-31')
);


INSERT INTO dbp_data.wg_filter_zu (mandant_id, wg_id, arthiertyp_id, wg_filter_id, wug_id)
(
    SELECT
        mandant_id,
        wg_id,
        arthiertyp_id,
        27 AS wg_filter_id,
        -1 AS wug_id
    FROM dbp_data.wg_per
    WHERE
        mandant_id = 1
        AND wg_id IN (134, 135, 136, 137, 138, 139, 141, 142, 144, 183, 143, 145, 187, 179, 181, 182)
        AND arthiertyp_id = 2
        AND dat_bis = PARSE_DATE('%F', '9999-12-31')
);


INSERT INTO dbp_data.wg_filter_zu (mandant_id, wg_id, arthiertyp_id, wg_filter_id, wug_id)
(
    SELECT
        mandant_id,
        wg_id,
        arthiertyp_id,
        28 AS wg_filter_id,
        -1 AS wug_id
    FROM dbp_data.wg_per
    WHERE
        mandant_id = 1
        AND wg_id IN (122, 128, 183, 184, 146, 147, 186, 185, 148)
        AND arthiertyp_id = 2
        AND dat_bis = PARSE_DATE('%F', '9999-12-31')
);


INSERT INTO dbp_data.wg_filter_zu (mandant_id, wg_id, arthiertyp_id, wg_filter_id, wug_id)
(
    SELECT
        mandant_id,
        wg_id,
        arthiertyp_id,
        29 AS wg_filter_id,
        -1 AS wug_id
    FROM dbp_data.wg_per
    WHERE
        mandant_id > 1
        AND wg_id IN (122, 128, 183, 184, 146, 147, 186, 185, 282, 283, 284, 285, 286, 288, 289, 293, 294, 148)
        AND arthiertyp_id = 2
        AND dat_bis = PARSE_DATE('%F', '9999-12-31')
);


INSERT INTO dbp_data.wg_filter_zu (mandant_id, wg_id, arthiertyp_id, wg_filter_id, wug_id)
(
    SELECT
        mandant_id,
        wg_id,
        arthiertyp_id,
        30 AS wg_filter_id,
        -1 AS wug_id
    FROM dbp_data.wg_per
    WHERE
        abt_id IN (8)
        AND arthiertyp_id = 2
        AND dat_bis = PARSE_DATE('%F', '9999-12-31')
);


INSERT INTO dbp_data.wg_filter_zu (mandant_id, wg_id, arthiertyp_id, wg_filter_id, wug_id)
(SELECT
    mandant_id,
    wg_id,
    arthiertyp_id,
    31 AS wg_filter_id,
    -1 AS wug_id
FROM dbp_data.wg_per
WHERE wg_id IN (
    534, 535, 536, 537, 538, 539, 541, 542, 543, 544, 545, 546, 547, 548, 549, 551, 552, 553, 554, 555, 556,
    557, 558, 559, 561, 562, 563, 564, 565, 566, 567, 568, 569, 571, 572, 573, 574, 575, 576, 577, 578, 579, 581, 582,
    583, 584, 658, 662, 663, 664, 665
)
AND arthiertyp_id = 2
AND dat_bis = PARSE_DATE('%F', '9999-12-31'));


INSERT INTO dbp_data.wg_filter_zu (mandant_id, wg_id, arthiertyp_id, wg_filter_id, wug_id)
(
    SELECT
        mandant_id,
        wg_id,
        arthiertyp_id,
        32 AS wg_filter_id,
        -1 AS wug_id
    FROM dbp_data.wg_per
    WHERE
        abt_id = 8
        AND arthiertyp_id = 2
        AND dat_bis = PARSE_DATE('%F', '9999-12-31')
);


INSERT INTO dbp_data.wg_filter_zu (mandant_id, wg_id, arthiertyp_id, wg_filter_id, wug_id)
(
    SELECT
        mandant_id,
        wg_id,
        arthiertyp_id,
        33 AS wg_filter_id,
        -1 AS wug_id
    FROM dbp_data.wg_per
    WHERE
        wg_id BETWEEN 960 AND 968
        AND arthiertyp_id = 2
        AND dat_bis = PARSE_DATE('%F', '9999-12-31')
);


INSERT INTO dbp_data.wg_filter_zu (mandant_id, wg_id, arthiertyp_id, wg_filter_id, wug_id)
(
    SELECT
        mandant_id,
        wg_id,
        arthiertyp_id,
        34 AS wg_filter_id,
        -1 AS wug_id
    FROM dbp_data.wg_per
    WHERE
        wg_id BETWEEN 970 AND 979
        AND arthiertyp_id = 2
        AND dat_bis = PARSE_DATE('%F', '9999-12-31')
);


INSERT INTO dbp_data.wg_filter_zu (mandant_id, wg_id, arthiertyp_id, wg_filter_id, wug_id)
(
    SELECT
        mandant_id,
        wg_id,
        arthiertyp_id,
        35 AS wg_filter_id,
        -1 AS wug_id
    FROM dbp_data.wg_per
    WHERE
        wg_id IN (818, 969)
        AND arthiertyp_id = 2
        AND dat_bis = PARSE_DATE('%F', '9999-12-31')
);


INSERT INTO dbp_data.wg_filter_zu (mandant_id, wg_id, arthiertyp_id, wg_filter_id, wug_id)
(
    SELECT
        mandant_id,
        wg_id,
        arthiertyp_id,
        36 AS wg_filter_id,
        -1 AS wug_id
    FROM dbp_data.wg_per
    WHERE
        abt_id IN (5)
        AND arthiertyp_id = 2
        AND dat_bis = PARSE_DATE('%F', '9999-12-31')
);


INSERT INTO dbp_data.wg_filter_zu (mandant_id, wg_id, arthiertyp_id, wg_filter_id, wug_id)
(SELECT
    mandant_id,
    wg_id,
    arthiertyp_id,
    37 AS wg_filter_id,
    -1 AS wug_id
FROM dbp_data.wg_per
WHERE wg_id IN (
    122, 128, 129, 131, 132, 133, 134, 135, 136, 137, 138, 139, 141, 142, 143, 144, 145, 146, 147, 148, 149,
    152, 153, 154, 155, 156, 157, 158, 159, 161, 162, 163, 164, 179, 181, 182, 183, 184, 185, 186, 187, 232, 233, 234,
    235, 236, 237, 238, 239, 242, 243, 244, 245, 246, 299, 302, 303, 304, 305, 306, 307, 308, 309, 311, 312, 315, 316,
    317, 318, 319, 321, 322, 323, 324, 325, 326, 327, 331, 329, 188, 247, 248, 249, 251, 252, 253, 254, 255, 256, 267,
    258, 259
)
AND arthiertyp_id = 2
AND dat_bis = PARSE_DATE('%F', '9999-12-31'));


INSERT INTO dbp_data.wg_filter_zu (mandant_id, wg_id, arthiertyp_id, wg_filter_id, wug_id)
(
    SELECT
        mandant_id,
        wg_id,
        arthiertyp_id,
        38 AS wg_filter_id,
        -1 AS wug_id
    FROM dbp_data.wg_per
    WHERE
        wg_id IN (818, 969)
        AND arthiertyp_id = 2
        AND dat_bis = PARSE_DATE('%F', '9999-12-31')
);


INSERT INTO dbp_data.wg_filter_zu (mandant_id, wg_id, arthiertyp_id, wg_filter_id, wug_id)
(
    SELECT
        mandant_id,
        wg_id,
        arthiertyp_id,
        39 AS wg_filter_id,
        -1 AS wug_id
    FROM dbp_data.wg_per
    WHERE
        wg_id IN (980, 981)
        AND arthiertyp_id = 2
        AND dat_bis = PARSE_DATE('%F', '9999-12-31')
);


INSERT INTO dbp_data.wg_filter_zu (mandant_id, wg_id, arthiertyp_id, wg_filter_id, wug_id)
(
    SELECT
        mandant_id,
        wg_id,
        arthiertyp_id,
        40 AS wg_filter_id,
        -1 AS wug_id
    FROM dbp_data.wg_per
    WHERE
        owg_id IN (1091)
        AND arthiertyp_id = 2
        AND dat_bis = PARSE_DATE('%F', '9999-12-31')
        AND wg_id = 823
        AND mandant_id = 1
);


INSERT INTO dbp_data.wg_filter_zu (mandant_id, wg_id, arthiertyp_id, wg_filter_id, wug_id)
(
    SELECT
        mandant_id,
        wg_id,
        arthiertyp_id,
        40 AS wg_filter_id,
        1 AS wug_id
    FROM dbp_data.wg_per
    WHERE
        owg_id IN (1091)
        AND arthiertyp_id = 2
        AND dat_bis = PARSE_DATE('%F', '9999-12-31')
        AND wg_id = 823
);


INSERT INTO dbp_data.wg_filter_zu (mandant_id, wg_id, arthiertyp_id, wg_filter_id, wug_id)
(
    SELECT
        mandant_id,
        wg_id,
        arthiertyp_id,
        40 AS wg_filter_id,
        999 AS wug_id
    FROM dbp_data.wg_per
    WHERE
        owg_id IN (1091)
        AND arthiertyp_id = 2
        AND dat_bis = PARSE_DATE('%F', '9999-12-31')
        AND wg_id = 823
);


INSERT INTO dbp_data.wg_filter_zu (mandant_id, wg_id, arthiertyp_id, wg_filter_id, wug_id)
(SELECT
    mandant_id,
    wg_id,
    arthiertyp_id,
    43 AS wg_filter_id,
    -1 AS wug_id
FROM dbp_data.wg_per
WHERE wg_id IN (
    402, 403, 404, 405, 406, 407, 408, 409, 411, 412, 413, 414, 415, 416, 417, 418, 419, 421, 422, 423, 424,
    425, 426, 427, 428, 429, 431, 432, 433, 434, 435, 436, 437, 438, 439, 441, 442, 443, 444, 445, 446, 447, 448, 449,
    452, 453, 454, 455, 456, 457, 458, 459, 461, 462, 463, 464, 465, 466, 467, 468, 469, 471, 473, 474, 475, 476, 477,
    478, 479, 481, 482, 483, 484, 485, 486, 487, 488, 489, 491, 492, 493, 494, 495, 496, 497, 498, 499, 501, 502, 503,
    504, 505, 506, 507, 508, 509, 511, 512, 513, 514, 515, 516, 517, 518, 519, 521, 522, 523, 524, 525, 526, 527, 528,
    529, 531, 532, 533, 534, 535, 536, 537, 538, 539, 541, 542, 543, 544, 545, 546, 547, 548, 549, 551, 552, 553, 554,
    662, 555, 663, 556, 664, 557, 558, 665, 559, 561, 562, 563, 564, 565, 566, 567, 568, 569, 571, 572, 573, 574, 575,
    576, 577, 578, 579, 581, 582, 583, 584, 585, 586, 587, 588, 589, 591, 592, 593, 594, 595, 596, 597, 598, 599, 601,
    602, 603, 604, 605, 606, 607, 608, 609, 612, 613, 614, 615, 616, 617, 618, 619, 622, 623, 624, 625, 626, 627, 628,
    629, 631, 632, 633, 634, 635, 636, 637, 638, 639, 644, 645, 646, 647, 648, 649, 651, 652, 653, 654, 655, 656, 657,
    658, 659, 661
)
AND arthiertyp_id = 2
AND dat_bis = PARSE_DATE('%F', '9999-12-31'));


INSERT INTO dbp_data.wg_filter_zu (mandant_id, wg_id, arthiertyp_id, wg_filter_id, wug_id)
(SELECT
    mandant_id,
    wg_id,
    arthiertyp_id,
    44 AS wg_filter_id,
    -1 AS wug_id
FROM dbp_data.wg_per
WHERE wg_id IN (
    534, 535, 536, 537, 538, 539, 541, 542, 543, 544, 545, 546, 547, 548, 549, 551, 552, 553, 554, 555, 556,
    557, 558, 658, 662, 663, 664, 665, 576, 577, 578, 579, 581, 582, 583, 584
)
AND arthiertyp_id = 2
AND dat_bis = PARSE_DATE('%F', '9999-12-31'));


INSERT INTO dbp_data.wg_filter_zu (mandant_id, wg_id, arthiertyp_id, wg_filter_id, wug_id)
(
    SELECT
        mandant_id,
        wg_id,
        arthiertyp_id,
        45 AS wg_filter_id,
        -1 AS wug_id
    FROM dbp_data.wg_per
    WHERE
        wg_id IN (523, 524, 525, 526)
        AND arthiertyp_id = 2
        AND dat_bis = PARSE_DATE('%F', '9999-12-31')
);


INSERT INTO dbp_data.wg_filter_zu (mandant_id, wg_id, arthiertyp_id, wg_filter_id, wug_id)
(
    SELECT
        mandant_id,
        wg_id,
        arthiertyp_id,
        46 AS wg_filter_id,
        -1 AS wug_id
    FROM dbp_data.wg_per
    WHERE
        wg_id IN (158, 188, 159)
        AND arthiertyp_id = 2
        AND dat_bis = PARSE_DATE('%F', '9999-12-31')
);


INSERT INTO dbp_data.wg_filter_zu (mandant_id, wg_id, arthiertyp_id, wg_filter_id, wug_id)
(SELECT
    mandant_id,
    wg_id,
    CAST('2' AS INTEGER),
    47 AS wg_filter_id,
    -1 AS wug_id
FROM dbp_data.wg_per
WHERE wg_id IN (
    232, 233, 234, 235, 236, 237, 238, 239, 242, 243, 244, 245, 246, 247, 248, 249, 251, 252, 253, 254, 255,
    256, 257, 258, 259, 261, 262, 263, 264, 265, 266, 267, 268, 269, 272, 273, 274, 275, 276, 277, 278, 279, 281, 282,
    283, 284, 285, 286, 288, 289, 293, 294, 295, 296, 297, 298, 299, 302, 303, 304, 305, 306, 307, 308, 309, 311, 312,
    313, 314, 315, 316, 317, 318, 319, 321, 322, 323, 324, 325, 326, 327, 328, 331, 402, 403, 404, 405, 406, 407, 408,
    409, 411, 412, 413, 414, 415, 416, 417, 418, 419, 421, 422, 423, 424, 425, 426, 427, 428, 429, 431, 432, 433, 434,
    435, 436, 437, 438, 439, 441, 442, 443, 444, 445, 446, 447, 448, 449, 452, 453, 454, 455, 456, 457, 458, 459, 461,
    462, 463, 464, 465, 466, 467, 468, 469, 471, 473, 474, 475, 476, 477, 478, 481, 482, 483, 484, 485, 486, 487, 488,
    489, 491, 492, 493, 494, 495, 496, 497, 498, 499, 501, 502, 503, 504, 505, 506, 507, 508, 509, 511, 512, 513, 514,
    515, 516, 517, 518, 519, 521, 522, 523, 524, 525, 526, 527, 528, 529, 531, 532, 533, 534, 535, 536, 537, 538, 539,
    541, 542, 543, 544, 545, 546, 547, 548, 549, 551, 552, 553, 554, 555, 556, 557, 558, 559, 561, 562, 563, 564, 565,
    566, 567, 568, 569, 571, 572, 573, 574, 575, 576, 577, 578, 579, 581, 582, 583, 584, 585, 586, 587, 588, 589, 591,
    592, 593, 594, 595, 596, 597, 598, 599, 601, 602, 603, 604, 605, 606, 607, 608, 609, 612, 613, 614, 615, 616, 617,
    618, 619, 622, 623, 624, 625, 626, 627, 628, 629, 631, 632, 633, 634, 635, 636, 637, 638, 639, 644, 645, 646, 647,
    648, 649, 651, 652, 653, 654, 655, 656, 657, 658, 659, 661, 662, 663, 664, 665
)
AND mandant_id > 1
AND arthiertyp_id = 2
AND dat_bis = PARSE_DATE('%F', '9999-12-31'));


--SPEC0152305


INSERT INTO dbp_data.l_wg_filter (wg_filter_id, kommentar, td_insert, td_update)
VALUES (48, 'mandant_id in (2,6) and wg_id in (315,316,317,318,319,322)', NULL, NULL);


INSERT INTO dbp_data.wg_filter_spr_zu (wg_filter_id, spr_id, wg_filter_bez, td_insert, td_update)
VALUES (48, 22, 'Kollimengen LIPS aus BME berechnen (WG Eier + Fertig-Brötchen CZ+HR)', NULL, NULL);


INSERT INTO dbp_data.wg_filter_zu (mandant_id, wg_id, arthiertyp_id, wg_filter_id, wug_id)
VALUES (2, 315, 2, 48, -1);


INSERT INTO dbp_data.wg_filter_zu (mandant_id, wg_id, arthiertyp_id, wg_filter_id, wug_id)
VALUES (2, 316, 2, 48, -1);


INSERT INTO dbp_data.wg_filter_zu (mandant_id, wg_id, arthiertyp_id, wg_filter_id, wug_id)
VALUES (2, 317, 2, 48, -1);


INSERT INTO dbp_data.wg_filter_zu (mandant_id, wg_id, arthiertyp_id, wg_filter_id, wug_id)
VALUES (2, 318, 2, 48, -1);


INSERT INTO dbp_data.wg_filter_zu (mandant_id, wg_id, arthiertyp_id, wg_filter_id, wug_id)
VALUES (2, 319, 2, 48, -1);


INSERT INTO dbp_data.wg_filter_zu (mandant_id, wg_id, arthiertyp_id, wg_filter_id, wug_id)
VALUES (2, 322, 2, 48, -1);


INSERT INTO dbp_data.wg_filter_zu (mandant_id, wg_id, arthiertyp_id, wg_filter_id, wug_id)
VALUES (6, 315, 2, 48, -1);


INSERT INTO dbp_data.wg_filter_zu (mandant_id, wg_id, arthiertyp_id, wg_filter_id, wug_id)
VALUES (6, 316, 2, 48, -1);


INSERT INTO dbp_data.wg_filter_zu (mandant_id, wg_id, arthiertyp_id, wg_filter_id, wug_id)
VALUES (6, 317, 2, 48, -1);


INSERT INTO dbp_data.wg_filter_zu (mandant_id, wg_id, arthiertyp_id, wg_filter_id, wug_id)
VALUES (6, 318, 2, 48, -1);


INSERT INTO dbp_data.wg_filter_zu (mandant_id, wg_id, arthiertyp_id, wg_filter_id, wug_id)
VALUES (6, 319, 2, 48, -1);


INSERT INTO dbp_data.wg_filter_zu (mandant_id, wg_id, arthiertyp_id, wg_filter_id, wug_id)
VALUES (6, 322, 2, 48, -1);


--SPEC0152305 END

--Alex Wolter, VIS-Filter (24.07.2023), Start


INSERT INTO dbp_data.l_wg_filter (wg_filter_id, kommentar, td_insert, td_update)
VALUES (49, 'mandant_id in (1,2,3,4,5,6,7,8) and wg_id in (961,962)', NULL, NULL);


INSERT INTO dbp_data.wg_filter_spr_zu (wg_filter_id, spr_id, wg_filter_bez, td_insert, td_update)
VALUES (49, 22, 'Telefonkarten', NULL, NULL);


INSERT INTO dbp_data.wg_filter_zu (mandant_id, wg_id, arthiertyp_id, wg_filter_id, wug_id)
VALUES (1, 961, 2, 49, -1);


INSERT INTO dbp_data.wg_filter_zu (mandant_id, wg_id, arthiertyp_id, wg_filter_id, wug_id)
VALUES (2, 961, 2, 49, -1);


INSERT INTO dbp_data.wg_filter_zu (mandant_id, wg_id, arthiertyp_id, wg_filter_id, wug_id)
VALUES (3, 961, 2, 49, -1);


INSERT INTO dbp_data.wg_filter_zu (mandant_id, wg_id, arthiertyp_id, wg_filter_id, wug_id)
VALUES (4, 961, 2, 49, -1);


INSERT INTO dbp_data.wg_filter_zu (mandant_id, wg_id, arthiertyp_id, wg_filter_id, wug_id)
VALUES (5, 961, 2, 49, -1);


INSERT INTO dbp_data.wg_filter_zu (mandant_id, wg_id, arthiertyp_id, wg_filter_id, wug_id)
VALUES (6, 961, 2, 49, -1);


INSERT INTO dbp_data.wg_filter_zu (mandant_id, wg_id, arthiertyp_id, wg_filter_id, wug_id)
VALUES (7, 961, 2, 49, -1);


INSERT INTO dbp_data.wg_filter_zu (mandant_id, wg_id, arthiertyp_id, wg_filter_id, wug_id)
VALUES (8, 961, 2, 49, -1);


INSERT INTO dbp_data.wg_filter_zu (mandant_id, wg_id, arthiertyp_id, wg_filter_id, wug_id)
VALUES (1, 962, 2, 49, -1);


INSERT INTO dbp_data.wg_filter_zu (mandant_id, wg_id, arthiertyp_id, wg_filter_id, wug_id)
VALUES (2, 962, 2, 49, -1);


INSERT INTO dbp_data.wg_filter_zu (mandant_id, wg_id, arthiertyp_id, wg_filter_id, wug_id)
VALUES (3, 962, 2, 49, -1);


INSERT INTO dbp_data.wg_filter_zu (mandant_id, wg_id, arthiertyp_id, wg_filter_id, wug_id)
VALUES (4, 962, 2, 49, -1);


INSERT INTO dbp_data.wg_filter_zu (mandant_id, wg_id, arthiertyp_id, wg_filter_id, wug_id)
VALUES (5, 962, 2, 49, -1);


INSERT INTO dbp_data.wg_filter_zu (mandant_id, wg_id, arthiertyp_id, wg_filter_id, wug_id)
VALUES (6, 962, 2, 49, -1);


INSERT INTO dbp_data.wg_filter_zu (mandant_id, wg_id, arthiertyp_id, wg_filter_id, wug_id)
VALUES (7, 962, 2, 49, -1);


INSERT INTO dbp_data.wg_filter_zu (mandant_id, wg_id, arthiertyp_id, wg_filter_id, wug_id)
VALUES (8, 962, 2, 49, -1);


--Alex Wolter, VIS-Filter (24.07.2023), Ende

--Nic Wagner, AVQ-Filter (15.08.2023), Start

--Doppelzuordnung WG 183 entfernen


DELETE FROM dbp_data.wg_filter_zu
WHERE wg_filter_id IN (27, 28);


--Neue Bez. + neuer Filter 50


DELETE FROM dbp_data.wg_filter_spr_zu
WHERE wg_filter_id IN (27, 28);


INSERT INTO dbp_data.wg_filter_spr_zu (wg_filter_id, spr_id, wg_filter_bez, td_insert, td_update)
VALUES (27, 22, 'AVQ (DE/KMO) WE 3 Tage vor Werbebeginn', NULL, NULL);


INSERT INTO dbp_data.wg_filter_spr_zu (wg_filter_id, spr_id, wg_filter_bez, td_insert, td_update)
VALUES (28, 22, 'AVQ (DE/KMO) WE 1 Tag vor Werbebeginn', NULL, NULL);


INSERT INTO dbp_data.wg_filter_spr_zu (wg_filter_id, spr_id, wg_filter_bez, td_insert, td_update)
VALUES (50, 22, 'AVQ (DE/KMO) WE am 1. Werbetag', NULL, NULL);


--neuer Filter 50


INSERT INTO dbp_data.wg_filter_zu
(
    SELECT
        mandant_id,
        wg_id,
        arthiertyp_id,
        50 AS wg_filter_id,
        -1 AS wug_id,
        CAST(NULL AS TIMESTAMP),
        CAST(NULL AS TIMESTAMP)
    FROM dbp_data.wg_per
    WHERE
        wg_id IN (161, 163, 164, 201, 202, 203, 204, 205, 206, 207, 208, 209, 211, 212, 213, 214, 215, 216, 217)
        AND dat_bis = DATE '9999-12-31'
        AND arthiertyp_id = 2
);


--zus. Mandanten 27


INSERT INTO dbp_data.wg_filter_zu
(
    SELECT
        mandant_id,
        wg_id,
        arthiertyp_id,
        27 AS wg_filter_id,
        -1 AS wug_id,
        CAST(NULL AS TIMESTAMP),
        CAST(NULL AS TIMESTAMP)
    FROM dbp_data.wg_per
    WHERE
        wg_id IN (134, 135, 136, 137, 138, 139, 141, 142, 143, 144, 145, 179, 181, 182, 187)
        AND dat_bis = DATE '9999-12-31'
        AND arthiertyp_id = 2
);


--zus. Mandanten 28


INSERT INTO dbp_data.wg_filter_zu
(
    SELECT
        mandant_id,
        wg_id,
        arthiertyp_id,
        28 AS wg_filter_id,
        -1 AS wug_id,
        CAST(NULL AS TIMESTAMP),
        CAST(NULL AS TIMESTAMP)
    FROM dbp_data.wg_per
    WHERE
        wg_id IN (122, 128, 146, 147, 148, 162, 183, 184, 185, 186, 191, 192)
        AND dat_bis = DATE '9999-12-31'
        AND arthiertyp_id = 2
);


--Nic Wagner, AVQ-Filter (15.08.2023), Ende


--new Sortimentstool filter


INSERT INTO dbp_data.wg_filter_zu (
    mandant_id, wg_id, arthiertyp_id, wg_filter_id, wug_id, td_update,
    td_insert
)
SELECT
    1 AS mandant_id,
    191 AS wg_id,
    2 AS arthiertyp_id,
    11 AS wg_filter_id,
    -1 AS wug_id,
    CURRENT_TIMESTAMP() AS td_update,
    CURRENT_TIMESTAMP() AS td_insert
UNION ALL
SELECT
    1 AS mandant_id,
    218 AS wg_id,
    2 AS arthiertyp_id,
    11 AS wg_filter_id,
    -1 AS wug_id,
    CURRENT_TIMESTAMP() AS td_update,
    CURRENT_TIMESTAMP() AS td_insert
UNION ALL
SELECT
    2 AS mandant_id,
    191 AS wg_id,
    2 AS arthiertyp_id,
    47 AS wg_filter_id,
    -1 AS wug_id,
    CURRENT_TIMESTAMP() AS td_update,
    CURRENT_TIMESTAMP() AS td_insert
UNION ALL
SELECT
    2 AS mandant_id,
    218 AS wg_id,
    2 AS arthiertyp_id,
    47 AS wg_filter_id,
    -1 AS wug_id,
    CURRENT_TIMESTAMP() AS td_update,
    CURRENT_TIMESTAMP() AS td_insert
UNION ALL
SELECT
    3 AS mandant_id,
    191 AS wg_id,
    2 AS arthiertyp_id,
    47 AS wg_filter_id,
    -1 AS wug_id,
    CURRENT_TIMESTAMP() AS td_update,
    CURRENT_TIMESTAMP() AS td_insert
UNION ALL
SELECT
    3 AS mandant_id,
    218 AS wg_id,
    2 AS arthiertyp_id,
    47 AS wg_filter_id,
    -1 AS wug_id,
    CURRENT_TIMESTAMP() AS td_update,
    CURRENT_TIMESTAMP() AS td_insert
UNION ALL
SELECT
    5 AS mandant_id,
    191 AS wg_id,
    2 AS arthiertyp_id,
    47 AS wg_filter_id,
    -1 AS wug_id,
    CURRENT_TIMESTAMP() AS td_update,
    CURRENT_TIMESTAMP() AS td_insert
UNION ALL
SELECT
    5 AS mandant_id,
    218 AS wg_id,
    2 AS arthiertyp_id,
    47 AS wg_filter_id,
    -1 AS wug_id,
    CURRENT_TIMESTAMP() AS td_update,
    CURRENT_TIMESTAMP() AS td_insert
UNION ALL
SELECT
    6 AS mandant_id,
    191 AS wg_id,
    2 AS arthiertyp_id,
    47 AS wg_filter_id,
    -1 AS wug_id,
    CURRENT_TIMESTAMP() AS td_update,
    CURRENT_TIMESTAMP() AS td_insert
UNION ALL
SELECT
    6 AS mandant_id,
    218 AS wg_id,
    2 AS arthiertyp_id,
    47 AS wg_filter_id,
    -1 AS wug_id,
    CURRENT_TIMESTAMP() AS td_update,
    CURRENT_TIMESTAMP() AS td_insert
UNION ALL
SELECT
    7 AS mandant_id,
    191 AS wg_id,
    2 AS arthiertyp_id,
    47 AS wg_filter_id,
    -1 AS wug_id,
    CURRENT_TIMESTAMP() AS td_update,
    CURRENT_TIMESTAMP() AS td_insert
UNION ALL
SELECT
    7 AS mandant_id,
    218 AS wg_id,
    2 AS arthiertyp_id,
    47 AS wg_filter_id,
    -1 AS wug_id,
    CURRENT_TIMESTAMP() AS td_update,
    CURRENT_TIMESTAMP() AS td_insert
UNION ALL
SELECT
    8 AS mandant_id,
    191 AS wg_id,
    2 AS arthiertyp_id,
    47 AS wg_filter_id,
    -1 AS wug_id,
    CURRENT_TIMESTAMP() AS td_update,
    CURRENT_TIMESTAMP() AS td_insert
UNION ALL
SELECT
    8 AS mandant_id,
    218 AS wg_id,
    2 AS arthiertyp_id,
    47 AS wg_filter_id,
    -1 AS wug_id,
    CURRENT_TIMESTAMP() AS td_update,
    CURRENT_TIMESTAMP() AS td_insert
UNION ALL
SELECT
    2 AS mandant_id,
    191 AS wg_id,
    2 AS arthiertyp_id,
    11 AS wg_filter_id,
    -1 AS wug_id,
    CURRENT_TIMESTAMP() AS td_update,
    CURRENT_TIMESTAMP() AS td_insert
UNION ALL
SELECT
    2 AS mandant_id,
    218 AS wg_id,
    2 AS arthiertyp_id,
    11 AS wg_filter_id,
    -1 AS wug_id,
    CURRENT_TIMESTAMP() AS td_update,
    CURRENT_TIMESTAMP() AS td_insert
UNION ALL
SELECT
    3 AS mandant_id,
    191 AS wg_id,
    2 AS arthiertyp_id,
    11 AS wg_filter_id,
    -1 AS wug_id,
    CURRENT_TIMESTAMP() AS td_update,
    CURRENT_TIMESTAMP() AS td_insert
UNION ALL
SELECT
    3 AS mandant_id,
    218 AS wg_id,
    2 AS arthiertyp_id,
    11 AS wg_filter_id,
    -1 AS wug_id,
    CURRENT_TIMESTAMP() AS td_update,
    CURRENT_TIMESTAMP() AS td_insert
UNION ALL
SELECT
    5 AS mandant_id,
    191 AS wg_id,
    2 AS arthiertyp_id,
    11 AS wg_filter_id,
    -1 AS wug_id,
    CURRENT_TIMESTAMP() AS td_update,
    CURRENT_TIMESTAMP() AS td_insert
UNION ALL
SELECT
    5 AS mandant_id,
    218 AS wg_id,
    2 AS arthiertyp_id,
    11 AS wg_filter_id,
    -1 AS wug_id,
    CURRENT_TIMESTAMP() AS td_update,
    CURRENT_TIMESTAMP() AS td_insert
UNION ALL
SELECT
    6 AS mandant_id,
    191 AS wg_id,
    2 AS arthiertyp_id,
    11 AS wg_filter_id,
    -1 AS wug_id,
    CURRENT_TIMESTAMP() AS td_update,
    CURRENT_TIMESTAMP() AS td_insert
UNION ALL
SELECT
    6 AS mandant_id,
    218 AS wg_id,
    2 AS arthiertyp_id,
    11 AS wg_filter_id,
    -1 AS wug_id,
    CURRENT_TIMESTAMP() AS td_update,
    CURRENT_TIMESTAMP() AS td_insert
UNION ALL
SELECT
    7 AS mandant_id,
    191 AS wg_id,
    2 AS arthiertyp_id,
    11 AS wg_filter_id,
    -1 AS wug_id,
    CURRENT_TIMESTAMP() AS td_update,
    CURRENT_TIMESTAMP() AS td_insert
UNION ALL
SELECT
    7 AS mandant_id,
    218 AS wg_id,
    2 AS arthiertyp_id,
    11 AS wg_filter_id,
    -1 AS wug_id,
    CURRENT_TIMESTAMP() AS td_update,
    CURRENT_TIMESTAMP() AS td_insert
UNION ALL
SELECT
    8 AS mandant_id,
    191 AS wg_id,
    2 AS arthiertyp_id,
    11 AS wg_filter_id,
    -1 AS wug_id,
    CURRENT_TIMESTAMP() AS td_update,
    CURRENT_TIMESTAMP() AS td_insert
UNION ALL
SELECT
    8 AS mandant_id,
    218 AS wg_id,
    2 AS arthiertyp_id,
    11 AS wg_filter_id,
    -1 AS wug_id,
    CURRENT_TIMESTAMP() AS td_update,
    CURRENT_TIMESTAMP() AS td_insert;


-- Nic Wagner, Autodispo (15.05.2025)


INSERT INTO dbp_data.wg_filter_spr_zu (wg_filter_id, spr_id, wg_filter_bez, td_insert, td_update)
VALUES (51, 22, 'Fleisch Autodispo', NULL, NULL);


INSERT INTO dbp_data.wg_filter_zu (
    mandant_id, wg_id, arthiertyp_id, wg_filter_id, wug_id, td_update,
    td_insert
)
VALUES (1, 146, 2, 51, -1, CURRENT_TIMESTAMP(), CURRENT_TIMESTAMP());


INSERT INTO dbp_data.wg_filter_zu (
    mandant_id, wg_id, arthiertyp_id, wg_filter_id, wug_id, td_update,
    td_insert
)
VALUES (1, 147, 2, 51, -1, CURRENT_TIMESTAMP(), CURRENT_TIMESTAMP());


INSERT INTO dbp_data.wg_filter_zu (
    mandant_id, wg_id, arthiertyp_id, wg_filter_id, wug_id, td_update,
    td_insert
)
VALUES (1, 186, 2, 51, -1, CURRENT_TIMESTAMP(), CURRENT_TIMESTAMP());


INSERT INTO dbp_data.wg_filter_zu (
    mandant_id, wg_id, arthiertyp_id, wg_filter_id, wug_id, td_update,
    td_insert
)
VALUES (1, 192, 2, 51, -1, CURRENT_TIMESTAMP(), CURRENT_TIMESTAMP());
