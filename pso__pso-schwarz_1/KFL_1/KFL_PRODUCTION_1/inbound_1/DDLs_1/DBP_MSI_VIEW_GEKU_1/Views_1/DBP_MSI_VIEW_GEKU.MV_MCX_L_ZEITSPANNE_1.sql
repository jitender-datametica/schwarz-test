CREATE OR REPLACE VIEW DBP_MSI_VIEW_GEKU.MV_MCX_L_ZEITSPANNE_1
(
zeitspanne_id
,zeitspanne_sort_key
)
AS
--lsvi0303: AP0043627, SPEC0055162 Atributt Einkaufszeit

SELECT 

zeitspanne_id
,zeitspanne_sort_key

FROM dbp_view.v_mcx_l_zeitspanne_1;