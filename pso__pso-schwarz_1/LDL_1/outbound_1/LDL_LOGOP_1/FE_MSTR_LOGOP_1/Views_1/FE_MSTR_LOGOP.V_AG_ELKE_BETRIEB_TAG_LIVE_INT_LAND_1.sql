/*
====================================================================================================
Division:           Lidl
Solution:           Operational Logistics (LOGOP)
DB schema:          fe_mstr_logop
DB table/view:      V_AG_ELKE_BETRIEB_TAG_LIVE_INT_LAND_1
====================================================================================================
Change history:     version, date, developer, comment
    1.0     2026-01.13     Simeon Nikolaev            Initial version
====================================================================================================
*/


CREATE OR REPLACE VIEW ldl_logop_fe_mstr_logop.v_ag_elke_betrieb_tag_live_int_land_1 (geschaeftsjahr, datum, client_id,
land_1, landeskuerzel, land_sort_nr, gesellschaft_nr, gesellschaftskuerzel, gesellschaft, gesellschaftstyp, woche_1,
gesellschaft_nr_name, lagerumsatz_brutto_eur, retourenwert_brutto_eur, lagerumsatz_netto_eur, retourenwert_netto_eur,
lagerumsatz_brutto_lw, retourenwert_brutto_lw, lagerumsatz_netto_lw, retourenwert_netto_lw, paletten_wareneingang_ep,
nettokolli_kommissionierung, kommissionierzeit_sec, paletten_fuer_filialbelieferung_ep,
paletten_keine_filialbelieferung_ep, anzahl_lkw_fuer_filialbelieferung_ep, anzahl_schichten_fuer_filialbelieferung_ep,
anzahl_touren_fuer_filialbelieferung_ep, einsatzzeit_fuer_filialbelieferung_ep, kilometer_km_fuer_filialbelieferung_ep,
dv_diesel_fuer_filialbelieferung_ep, dv_lng_fuer_filialbelieferung_ep, dv_cng_fuer_filialbelieferung_ep,
dv_elektro_fuer_filialbelieferung_ep, dv_wasserstoff_fuer_filialbelieferung_ep, empfangene_cross_dock,
dv_versendete_cross_dock, dv_umlagerung, dv_aussenlager, dv_lieferung_intern, dv_lieferung_nonfood,
pallets_planned_on_shift_store_delivery, total_num_pallets_planned_on_tour_store_deliveries,
total_num_pallets_capacity_on_tour_store_deliveries, gesamtstunden_betrieb, externe_gesamtstunden_betrieb,
gesamtstunden_betrieb_inkl_externe, dv_betriebsrat, nettostunden_betriebsorganisation, dv_mehr_und_minderstunden,
operative_einarbeitung_betriebsorganisation, strategische_einarbeitung_betriebsorganisation,
externe_stunden_betriebsorganisation, gesamtstunden_betriebsorganisation, dv_teilnahme_schulung, nettostunden_prozesse,
dv_mehr_und_minderstunden_2, operative_einarbeitung_prozesse, strategische_einarbeitung_prozesse,
externe_stunden_prozesse, gesamtstunden_prozesse, dv_teilnahme_schulung_2, nettopicks_retouren, nettostunden_operative,
dv_mehr_und_minderstunden_3, operative_einarbeitung_operative, strategische_einarbeitung_operative,
externe_stunden_operative, gesamtstunden_operative, dv_wareneingang, dv_warenbereitstellung, dv_retouren,
dv_teilnahme_schulung_3, dv_akzise, dv_stickern, dv_inventur, dv_umpacken, nettostunden_haustechnik,
dv_mehr_und_minderstunden_4, operative_einarbeitung_haustechnik, strategische_einarbeitung_haustechnik,
externe_stunden_haustechnik, gesamtstunden_haustechnik, dv_organisatorische_taetigkeiten, dv_abarbeitung_checklisten,
dv_eigenreparaturen_und_stoerungsbeseitigung, dv_bereitschaftsdienst, dv_betreuung_externe_dienstleister,
dv_durchfuehrung_schulung, dv_teilnahme_schulung_4, warehouse_organization_1, warehouse_organization_2,
warehouse_organization_3, warehouse_organization_4, warehouse_organization_5, warehouse_organization_6,
warehouse_organization_7, warehouse_organization_8, warehouse_organization_9, warehouse_organization_10, process_1,
process_2, process_3, process_4, process_5, process_6, process_7, process_8, process_9, process_10, operation_1,
operation_2, operation_3, operation_4, operation_5, operation_6, operation_7, operation_8, operation_9, operation_10,
maintenance_automatization_1, maintenance_automatization_2, maintenance_automatization_3, maintenance_automatization_4,
maintenance_automatization_5, maintenance_automatization_6, maintenance_automatization_7, maintenance_automatization_8,
maintenance_automatization_9, maintenance_automatization_10) AS SELECT *
FROM ldl_logop_fe_mstr_logop.v_ag_elke_betrieb_tag_live_1;