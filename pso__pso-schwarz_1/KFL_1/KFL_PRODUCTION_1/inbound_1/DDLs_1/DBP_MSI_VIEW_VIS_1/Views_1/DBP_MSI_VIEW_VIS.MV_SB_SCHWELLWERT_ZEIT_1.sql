CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_SB_SCHWELLWERT_ZEIT_1 as
   -- LOOKUP Schnellbeurteilung Schwellwert Tageszeit
   -- 2011KW03 MR
   -- 20120419 : Review
   -- 20120510 : Erweiterung Vertrieb-FG
   -- 2012KW28 : Feintuning
   -- 2012KW37 : Review Spalten Quelltabelle + CASE Statements

   SELECT
   v01.mandant_id, v01.vertrieb_fg, v01.zeit_stunde_von, CASE WHEN zeit_stunde_bis = 24 THEN 23 ELSE zeit_stunde_bis END  AS zeit_stunde_bis, 0.00                   AS sw_dummy, 0.00                   AS sw_rot2_ab, v01.sw_rot_bis         AS sw_rot1_bis, CASE WHEN v01.sw_rot_bis BETWEEN 0.01 AND 99.99 THEN v01.sw_rot_bis + 0.01 ELSE v01.sw_rot_bis END AS sw_gelb2_ab, v01.sw_gelb_bis        AS sw_gelb1_bis, CASE WHEN v01.sw_gelb_bis BETWEEN 0.01 AND 99.99 THEN sw_gelb_bis + 0.01 ELSE v01.sw_gelb_bis END AS sw_gruen_ab, CASE WHEN v01.sw_gelb_ab BETWEEN 0.01 AND 99.99 THEN sw_gelb_ab - 0.01 ELSE v01.sw_gelb_ab END AS sw_gruen_bis, v01.sw_gelb_ab         AS sw_gelb1_ab, CASE WHEN v01.sw_rot_ab BETWEEN 0.01 AND 99.99 THEN v01.sw_rot_ab - 0.01 ELSE v01.sw_rot_ab END AS sw_gelb2_bis, v01.sw_rot_ab          AS sw_rot1_ab, 100.00                 AS sw_rot2_bis
   FROM dbp_view.v_sb_schwellwert_zeit_1 v01;