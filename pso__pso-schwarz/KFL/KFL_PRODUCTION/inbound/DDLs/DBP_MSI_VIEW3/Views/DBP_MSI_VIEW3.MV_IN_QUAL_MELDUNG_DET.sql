CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_IN_QUAL_MELDUNG_DET as
   SELECT
   v01.mandant_id, v01.qual_meldung_id, v01.qual_meldung_pos_id, v01.problemcode_id
   FROM dbp_view.v_in_qual_meldung_det v01
;