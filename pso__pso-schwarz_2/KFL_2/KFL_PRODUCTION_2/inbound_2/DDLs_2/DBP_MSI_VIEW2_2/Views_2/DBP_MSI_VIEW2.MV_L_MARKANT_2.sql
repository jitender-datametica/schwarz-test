CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_L_MARKANT_2
--27.09.2021 snik1809: AP0085198, SPEC0118722 - Created

(
 mandant_id
 , markant_id
)

AS

SELECT
 mandant_id
 , markant_id
FROM dbp_view.v_l_markant_2
WHERE mandant_id = 1;
