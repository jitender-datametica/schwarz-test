CREATE OR REPLACE VIEW DBP_MSI_VIEW_LOG.MV_L_LAGERAUFGABESTATUS_PROMPT(
	STATUS_ID
) AS
--2023-05-08, AP0161535, dknop, initial
      SELECT DISTINCT
      status_id
      FROM dbp_view.v_lageraufgabe;
      
