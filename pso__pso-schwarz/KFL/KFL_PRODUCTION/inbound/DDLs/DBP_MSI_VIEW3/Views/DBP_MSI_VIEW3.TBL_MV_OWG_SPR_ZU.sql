CREATE OR REPLACE VIEW DBP_MSI_VIEW3.TBL_MV_OWG_SPR_ZU
as 
   SELECT v01.owg_id, v01.owg_bez, CASE WHEN v01.owg_id < 0 THEN TO_VARCHAR(v01.owg_id, 'FM0000')
   ELSE TO_VARCHAR(v01.owg_id, 'FM0000')
   END || ' ' || v01.owg_bez AS owg_id_bez, v01.mandant_id, v01.arthiertyp_id, v01.spr_id
   FROM dbp_view.v_owg_spr_zu v01
   WHERE v01.arthiertyp_id = 2;