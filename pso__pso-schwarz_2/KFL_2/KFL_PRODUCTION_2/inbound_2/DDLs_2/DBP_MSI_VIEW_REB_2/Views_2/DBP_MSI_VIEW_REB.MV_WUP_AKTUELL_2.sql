CREATE OR REPLACE VIEW DBP_MSI_VIEW_REB.MV_WUP_AKTUELL_2
(
	AKTUELL_WUP_ID,
	NB_ID,
	MANDANT_ID,
	WUP_STANDORT,
	MARKT
)
AS
--07.08.2024 twie: SPEC0262756 neue View mit aktuell_wup_id als PK, ist Elternattribut zu Markt, vereint alte und neue wup_id bei Filialumgliederung in einem Datensatz, deshalb gruppieren

SELECT 

aktuell_wup_id,
nb_id,
mandant_id,
MAX(wup_standort) AS wup_standort,
MAX(TRIM(aktuell_wup_id || ' ' || wup_standort))  AS Markt,

FROM dbp_view.v_wup_2

WHERE mandant_id = 1
  AND (((dat_eroeffnung < CURRENT_DATE OR dat_eroeffnung< CURRENT_DATE +45)  AND dat_von IS NOT NULL) OR nb_id <> 0 OR wup_id = 9203)
  -- Filterung von Zentralfilialen
  AND NOT wup_id BETWEEN 1 AND 999
  -- 20100330 Filterung der IWT Betriebe
  AND nb_id <> 99

GROUP BY
aktuell_wup_id,
nb_id,
mandant_id;