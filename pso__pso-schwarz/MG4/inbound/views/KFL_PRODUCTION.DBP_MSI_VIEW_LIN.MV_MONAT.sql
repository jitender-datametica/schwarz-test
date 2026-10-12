create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_LIN.MV_MONAT(
	MO_KJ,
	KJ,
	KJMO,
	DAT_VON,
	KJMO_ORDER,
	KJMO_VORMONAT,
	AKT_MO,
	AKT_MO_KOMPLETT
) as
   SELECT
   mo_kj, kj, kjmo, dat_von, Rank() Over (ORDER BY kjmo) AS kjmo_order, kjmo_vormonat, akt_mo, akt_mo_komplett
   FROM
   (
   SELECT v01.mo_kj, v01.kj, v01.kjmo, min_dat AS dat_von, Max(v01.kjmo) Over (ORDER BY v01.kjmo ROWS BETWEEN 1 Preceding AND 1 Preceding) AS kjmo_vormonat, v01.akt_mo, v01.akt_mo_komplett
   FROM dbp_view.v_monat v01
   ) dt1
   
   
   WHERE dt1.akt_mo_komplett BETWEEN -3 AND 12;