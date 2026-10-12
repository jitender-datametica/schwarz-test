create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_GEKU_MATERIALIZED.MV_KMR_L_KAPITEL_TYP_2(
	KAPITEL_TYP_ID,
	KAPITEL_TYP_BEZ
) as
--03.08.2022 twie: SPEC0155060 Kapiteltyp für die Spezialview MV_KMR_L_KAPITEL_2, um zu erkennen, welcher Inhalt im Attribut Kapitel steckt (Prüfprogramm, Haupt-, Teil-, oder Unterbereich)

SELECT
kapitel_typ_id
,kapitel_typ_bez
FROM dbp_view.v_amx_l_kapitel_typ_2

WHERE AMX_SYSTEM_ID = 2;
