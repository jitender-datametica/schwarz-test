CREATE OR REPLACE VIEW DBP_MSI_VIEW_LOG.MV_L_LIEF_TYP_2
AS
--2024-06-05, dknop, initial

SELECT lief_typ_id 
FROM dbp_view.v_l_lief_typ_2
GROUP BY lief_typ_id;