CREATE OR REPLACE VIEW DBP_MSI_VIEW_LBS.MV_MANDANT_SECURITY_2(
	MANDANT_ID,
	MANDANT_BEZ,
	MANDANT_KBEZ
) AS

   SELECT 
    v01.mandant_id
   ,v01.mandant_bez
   ,v01.mandant_kbez

   FROM dbp_view.v_mandant_2 v01;