CREATE OR REPLACE VIEW dbp_msi_view2.mv_wbl_1
--lsvi0303: NSR2275474
(
ek_flg
,gf_id
,wbl_dat_von
,wbl_id
,wbl_name
,mandant_id
)
AS
SELECT
ek_fg,
gf_id,
wbl_dat_von,
wbl_id,
wbl_name,
mandant_id
FROM dbp_view.v_wbl_1
WHERE mandant_id = 1
AND wbl_dat_von >= CURRENT_DATE - 1;