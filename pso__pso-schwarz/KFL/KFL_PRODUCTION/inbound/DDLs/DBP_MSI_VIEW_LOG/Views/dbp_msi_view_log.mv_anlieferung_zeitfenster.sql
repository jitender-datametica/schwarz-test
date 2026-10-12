CREATE OR REPLACE VIEW dbp_msi_view_log.MV_ANLIEFERUNG_ZEITFENSTER(
	MERCAREON_STANDORT,
	MERCAREON_ENTLADESTELLE,
	DAT,
	ZEIT,
	ANZ_ZF_GESAMT,
	ANZ_ZF_GEBUCHT,
	ANZ_ZF_RESERVIERT,
	ANZ_ZF_GESPERRT,
	ANZ_ZF_FREI
) AS
--2022-03-29, AP0102132, SPEC0148033, initial, dknop
    SELECT 
         mercareon_standort
        ,mercareon_entladestelle
        ,dat
        ,zeit
        ,anz_zf_gesamt
        ,anz_zf_gebucht
        ,anz_zf_reserviert
        ,anz_zf_gesperrt
        ,anz_zf_frei


FROM dbp_view.v_anlieferung_zeitfenster ;