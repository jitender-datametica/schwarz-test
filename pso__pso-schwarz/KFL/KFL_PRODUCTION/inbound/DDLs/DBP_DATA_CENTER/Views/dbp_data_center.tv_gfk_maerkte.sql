CREATE OR REPLACE VIEW dbp_data_center.tv_gfk_maerkte
AS
SELECT
w.mandant_id,
w.fipo_pruef_objekt_id,
w.wup_id,
COALESCE(w.wup_name_e,w.wup_name_v) AS wup_name,
w.wup_str,
w.wup_plz,
w.wup_standort,
m.mandant_bez
FROM dbp_view.v_wup w
INNER JOIN dbp_view.v_mandant m
ON m.mandant_id = w.mandant_id
WHERE w.fipo_pruef_objekt_id <> -1
AND w.nb_id = 0
AND CURRENT_DATE BETWEEN w.dat_von AND w.dat_bis;