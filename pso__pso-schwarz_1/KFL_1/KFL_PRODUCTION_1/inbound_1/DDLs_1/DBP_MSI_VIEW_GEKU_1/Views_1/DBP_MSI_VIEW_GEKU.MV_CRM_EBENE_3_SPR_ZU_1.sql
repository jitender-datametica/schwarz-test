CREATE OR REPLACE VIEW DBP_MSI_VIEW_GEKU.MV_CRM_EBENE_3_SPR_ZU_1
AS
-- 23.07.2019 twie: SPEC0059158 Sprachview CRM Ebene 3 (unterste Stufe)
-- Tabelle crm_themenbaum_lv2_spr_zu_1 ist denormalisiert und enthält Ebene 1 + 2  + 3. Jeder Datensatz hat mit crm_themenbaum_lv2_id einen eindeutigen Schlüssel, der in MSI aber nicht relevant ist.

   SELECT

   v01.ebene_3_id
   , MAX(CASE WHEN v01.spr_id =   22 THEN v01.ebene_3_bez ELSE NULL END)  AS ebene_3_bez   --standard=deutsch
   , MAX(CASE WHEN v01.spr_id = 124 THEN v01.ebene_3_bez ELSE NULL END)  AS ebene_3_bez_cz
   , MAX(CASE WHEN v01.spr_id =   90 THEN v01.ebene_3_bez ELSE NULL END)  AS ebene_3_bez_pl
   , MAX(CASE WHEN v01.spr_id = 108 THEN v01.ebene_3_bez ELSE NULL END)  AS ebene_3_bez_sk
   , MAX(CASE WHEN v01.spr_id =   65 THEN v01.ebene_3_bez ELSE NULL END)  AS ebene_3_bez_hr
   , MAX(CASE WHEN v01.spr_id =   95 THEN v01.ebene_3_bez ELSE NULL END)  AS ebene_3_bez_ro
   , MAX(CASE WHEN v01.spr_id =   18 THEN v01.ebene_3_bez ELSE NULL END)  AS ebene_3_bez_bg

   FROM dbp_view.v_crm_themenbaum_lv2_spr_zu_1 v01

   GROUP BY v01.ebene_3_id;