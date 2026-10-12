CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_L_FAKTURA_TYP
(
mandant_id
, faktura_typ_id
, retoure_fg
)
AS
   SELECT
   v01.mandant_id, v01.faktura_typ_id, CASE WHEN v01.faktura_typ_id IN ('O','S') THEN 1 ELSE 0 END AS retoure_fg

   FROM dbp_view.v_besch_faktura v01
   WHERE  v01.mandant_id = 1

   GROUP BY 1,2;