CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_geku.mv_geku_gebiets_betreuer (gebiets_betreuer_uid, fv_fg, fv_gb_id
, gbb_name, gbb_vorname, gbb_anrede, gbb_strasse, gbb_plz, gbb_ort, gbb_land_id, mandant_id, gbb_email, gbb_tel_mobil,
gbb_telefon, gbb_fax) AS SELECT gebiets_betreuer_uid,
 fv_fg,
 fv_gb_id,
 gbb_name,
 gbb_vorname,
 gbb_anrede,
 gbb_strasse,
 gbb_plz,
 gbb_ort,
 gbb_land_id,
 mandant_id,
 gbb_email,
 gbb_tel_mobil,
 gbb_telefon,
 gbb_fax
FROM kfl_production_dbp_view.v_geku_gebiets_betreuer;