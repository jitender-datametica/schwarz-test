CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_ABSCHRIFT_GRUPPE_1 as
   --SPRACHE Abschrift-Gruppe_1
   --2010KW28 INITIAL
   --2011KW37: Internationaliserung (feste Sprache)
   --2015KW50: M.Gill: Umbau der Internationalisierung von Tabellen auf Spalten

   SELECT
   v01.mandant_id, v01.abschriftgruppe_id, MAX(CASE WHEN spr_id =  22 THEN abschriftgrp_bez END) AS abschriftgrp_bez                 -- standard == DE
   , MAX(CASE WHEN spr_id =  22 THEN abschriftgrp_bez END) AS abschriftgrp_bez_de                          -- DE
   , COALESCE(MAX(CASE WHEN spr_id = 124 THEN abschriftgrp_bez END), abschriftgrp_bez_de) AS abschriftgrp_bez_cz    -- CZ
   , COALESCE(MAX(CASE WHEN spr_id = 108 THEN abschriftgrp_bez END), abschriftgrp_bez_de) AS abschriftgrp_bez_sk    -- SK
   , COALESCE(MAX(CASE WHEN spr_id =  65 THEN abschriftgrp_bez END), abschriftgrp_bez_de) AS abschriftgrp_bez_hr    -- HR
   , COALESCE(MAX(CASE WHEN spr_id =  90 THEN abschriftgrp_bez END), abschriftgrp_bez_de) AS abschriftgrp_bez_pl    -- PL
   , COALESCE(MAX(CASE WHEN spr_id =  95 THEN abschriftgrp_bez END), abschriftgrp_bez_de) AS abschriftgrp_bez_ro    -- RO
   , COALESCE(MAX(CASE WHEN spr_id =  18 THEN abschriftgrp_bez END), abschriftgrp_bez_de) AS abschriftgrp_bez_bg    -- BG
   FROM dbp_view.v_abschrift_gruppe_spr_zu_1  v01

   GROUP BY 1,2;