CREATE OR REPLACE VIEW DBP_MSI_VIEW_WWC.MV_F_BESCH_FAKTURA_KONDIT_2
-- 20.03.2014 twie: Konditionen

(
mandant_id
,faktura_beleg_id
,faktura_beleg_pos_id
,beleg_kondition_id
,kondition_schl_id
,kondition_wert
,kappl
)
AS
   SELECT

   v01.mandant_id, v01.faktura_beleg_id, v01.faktura_beleg_pos_id, v01.beleg_kondition_id, v01.kondition_schl_id, CASE WHEN v200.wrg_typ_id = 1
   THEN v01.kondition_wert --Landeswährung
   ELSE TRUNC( v01.kondition_wert / v02.kurrf --Euro
   )
   END AS kondition_wert, v01.kappl

   FROM dbp_view.v_besch_faktura_kondit_2 v01
   LEFT OUTER JOIN dbp_view.v_besch_faktura_kmo_2 v02
   ON v01.mandant_id=v02.mandant_id
   AND v01.faktura_beleg_id=v02.faktura_beleg_id
   CROSS JOIN dbp_msi.akt_msi_user_wrg_typ_zu_2 v200
   ;