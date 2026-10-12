CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_IN_KUNDE_2
(
mandant_id
,in_kunde_id
,kunde_nr
,kunde_name
,system_id
)
AS
   SELECT
   mandant_id, in_kunde_id, kunde_nr, kunde_name, system_id
   FROM dbp_view.v_in_kunde_2
;