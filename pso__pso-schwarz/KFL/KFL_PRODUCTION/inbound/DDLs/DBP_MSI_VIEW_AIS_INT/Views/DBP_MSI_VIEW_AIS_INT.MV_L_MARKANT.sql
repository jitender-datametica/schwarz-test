CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_INT.MV_L_MARKANT
--27.09.2021 snik1809: AP0085198, SPEC0118722 - Created

(
 mandant_id
 , markant_id
)

AS

SELECT
 mandant_id
 , markant_id
FROM dbp_view.v_l_markant;