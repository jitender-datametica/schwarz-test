CREATE OR REPLACE VIEW DBP_MSI_VIEW_SCM.MV_AUTODISPO_DIF_TAG_2 
-- 02.03.2021, AP0068964, nwag2310, initial
-- 01.06.2021, AP0084960, SPEC0113040, srom0404 mapped to wup_id
AS
SELECT v01.mandant_id
      ,v01.kunde_id AS wup_id
      ,0 AS nb_id
      ,v01.art_id
      ,v01.dat
      ,v01.dat_ausfuehrung
      ,v01.dif_typ_id
      ,v01.dif_status_id
      ,v01.dif_wert
      ,v01.dif_kommentar
      ,v01.sap_returncode
FROM DBP_VIEW.v_autodispo_dif_tag_2 v01
;