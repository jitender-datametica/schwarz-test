CREATE OR REPLACE VIEW DBP_MSI_VIEW_BIS.MV_F_IN_BESCH_BEST_DET_2
   (
mandant_id
,buchungskreis_id
,best_beleg_id
,best_beleg_pos_id

,dat_buch
,dat_best_beleg
,bestellart_id
,in_art_id
,in_lief_id
,einkaufsorganisation_id

,werk_id
,vz_ind
,menge_best_bme
,menge_bme
,best_menge_einh_id
,besch_pos_typ_id
,betrag_pos_netto_best_wrg

,endrech_fg
,rech_plan_id
,dat_von_rb
,dat_aenderung
)
   AS 
   SELECT
   v01.mandant_id,
   v01.buchungskreis_id,
   v01.best_beleg_id,
   v01.best_beleg_pos_id,
   v01.dat_best_beleg  AS dat_buch,
   v01.dat_best_beleg,
   v01.bestellart_id,
   v01.in_art_id,
   v01.in_lief_id,
   v01.einkaufsorganisation_id,
   v01.werk_id,
   CASE WHEN retourenpos_fg = 1 THEN -1 ELSE 1 END vz_ind,
   v01.menge_best_bme * vz_ind -- in Bestellmengeneinheit, in MSI nicht mehr verwendet
   ,
   v01.menge_bme * vz_ind  -- in Basismengeneinheit
   ,
   v01.best_menge_einh_id,
   v01.besch_pos_typ_id,
   CASE WHEN v04.wrg_typ_id = 0
   THEN CAST(v01.betrag_pos_netto_best_wrg AS NUMBER(38,5))  * v01.umrechnungskurs * vz_ind
   ELSE CAST(v01.betrag_pos_netto_best_wrg AS NUMBER(38,5)) * vz_ind
   END betrag_pos_netto_best_wrg,
   v01.endrech_fg,
   v01.rech_plan_id,
   v01.dat_von_rb,
   v01.dat_aenderung
   FROM DBP_MSI_VIEW_BIS.tbl_MV_F_IN_BESCH_BEST_DET_2 v01
   CROSS JOIN dbp_msi.akt_msi_user_wrg_typ_zu_2 v04
;