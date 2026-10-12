CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_L_AUSLASTUNGSGRUND
(
mandant_id
,auslastungsgrund_id
,sap_auslastungsgrund
)
AS
   SELECT
   mandant_id, auslastungsgrund_id, sap_auslastungsgrund
   FROM dbp_view.v_l_auslastungsgrund
;