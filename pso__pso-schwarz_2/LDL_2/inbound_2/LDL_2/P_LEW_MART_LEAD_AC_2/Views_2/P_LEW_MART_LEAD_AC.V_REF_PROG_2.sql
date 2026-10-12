CREATE OR REPLACE VIEW P_LEW_MART_LEAD_AC.V_REF_PROG_2
(
  prog_sid
, prog_name
, prog_desc
, prog_start_tmsp
, prog_end_tmsp
, load_id
, dwh_inserted
, dwh_updated
)
AS
   SELECT
     prog_sid,
   prog_name,
   prog_desc,
   prog_start_tmsp,
   prog_end_tmsp,
   load_id,
   dwh_inserted,
   dwh_updated
  FROM p_lew_mart_lead.t_ref_prog_2
;