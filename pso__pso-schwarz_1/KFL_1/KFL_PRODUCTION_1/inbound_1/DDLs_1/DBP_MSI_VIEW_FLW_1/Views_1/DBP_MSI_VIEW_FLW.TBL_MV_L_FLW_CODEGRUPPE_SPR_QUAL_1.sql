CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.TBL_MV_L_FLW_CODEGRUPPE_SPR_QUAL_1
   as 
   -- 26.10.2011 system_id entfernt
   SELECT
   --  v01.system_id
   v01.mandant_id, v01.katalogart_id, v01.codegruppe_id, v01.spr_id, v01.codegruppe_bez

   FROM dbp_view.v_flw_codegruppe_spr_zu_1 v01

   --katalogart_id = 9 entspricht  Qualitaetsmeldung/Anlieferungsbewertung/Kopfbewertung
   WHERE v01.katalogart_id = '9';