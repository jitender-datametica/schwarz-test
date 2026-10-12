CREATE OR REPLACE VIEW dbp_msi_view_ek_sort.java_mandant
AS
SELECT
mandant_id,
mandant_bez,
mandant_kbez,
default_wrg
FROM dbp_view.v_mandant
WHERE mandant_id NOT IN (4);