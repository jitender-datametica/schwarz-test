CREATE OR REPLACE VIEW p_lew_process_ac.v_wawi_tobelist_p2wk
(
   country_iso_cd
  ,country_id
  ,wh_id
  ,client_id
  ,loc_sid_wh
  ,interface_desc
  ,interface_key
  ,system_key
  ,EJR
  ,test_flag
)
AS
SELECT
country_iso_cd,
country_id,
wh_id,
client_id,
loc_sid_wh,
interface_desc,
interface_key,
system_key,
EJR,
test_flag
FROM p_lew_process.v_wawi_tobelist_p2wk
;

