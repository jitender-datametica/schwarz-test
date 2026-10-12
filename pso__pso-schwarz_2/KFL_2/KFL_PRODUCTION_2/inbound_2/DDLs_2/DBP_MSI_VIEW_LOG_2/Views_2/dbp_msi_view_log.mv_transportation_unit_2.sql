CREATE OR REPLACE VIEW dbp_msi_view_log.mv_transportation_unit_2(
	MANDANT_ID,
	TRANSPORTATION_UNIT_ID,
    KJ_TRANSPORTATION_UNIT,
	TRANSPORTATION_UNIT_ID_EXT,
	LIME_ID,
	LIME_ID_AUSGEPACKT,
	HANDLING_UNIT_GUID,
	TRANSPORTMITTEL,
	EIGENTUEMER,
	FRACHTFUEHRER,
	SCAC,
	MAX_ANZ_SIEGEL,
	FAHRZEUGNUMMER_INTERN,
	LAND_KFZ_KENNZEICHEN,
	KFZ_KENNZEICHEN,
	TU_PERMANENT_FG,
	TU_HEAD_FG,
	TOR_VORBELADEN_FG,
	LKW_VORGEKUEHLT_FG,
	RUNDLAUF_FG,
	HU_GEWICHT,
	HU_GEWICHT_MENGE_EINH_ID
) AS
  -- 18.09.2020, AP0064865, SPEC0085770, baranowska, create view
--2023-05-09, dknop, AP0161535_SPEC0198264, adding tor_vorbeladen_fg
--2024-08-25, nwag, limit on TD_INSERT because of dups
--2024-11-14, AP0240092, nwag, add KJ_TRANSPORTATION_UNIT
SELECT
v01.mandant_id,
v01.transportation_unit_id,
v01.KJ_TRANSPORTATION_UNIT,
v01.transportation_unit_id_ext,
v01.lime_id,
v01.lime_id_ausgepackt,
v01.handling_unit_guid,
v01.transportmittel,
v01.eigentuemer,
v01.frachtfuehrer,
v01.scac,
v01.max_anz_siegel,
v01.fahrzeugnummer_intern,
v01.land_kfz_kennzeichen,
v01.kfz_kennzeichen,
v01.tu_permanent_fg,
v01.tu_head_fg,
COALESCE(NULLIF(v01.tor_vorbeladen_fg,''),0) AS tor_vorbeladen_fg,
v01.lkw_vorgekuehlt_fg,
v01.rundlauf_fg,
v01.hu_gewicht,
v01.hu_gewicht_menge_einh_id

FROM dbp_view.v_transportation_unit_2 v01
WHERE KJ_TRANSPORTATION_UNIT >= YEAR(CURRENT_DATE)-2;