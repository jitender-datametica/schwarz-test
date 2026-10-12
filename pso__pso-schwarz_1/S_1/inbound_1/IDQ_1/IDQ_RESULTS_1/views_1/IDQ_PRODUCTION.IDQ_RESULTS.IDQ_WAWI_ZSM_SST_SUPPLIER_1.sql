create or replace VIEW IDQ_PRODUCTION.IDQ_RESULTS.IDQ_WAWI_ZSM_SST_SUPPLIER_1(
	REGEL_ID,
	CATALOG_ID,
	REGELKURZBESCHREIBUNG,
	FEHLERMELDUNG,
	REGELGRUPPENAME,
	KRITIKALITAET,
	SCORE,
	OBJEKT_ID,
	LIEFNR,
	LIEFERANT,
	STATUSLIEFERANT,
	KONTENGRUPPE,
	EKSNUMMER,
	LAND_1,
	M,
	NF,
	EM,
	O_G,
	B_P,
	IMP,
	VERHANDELNDESLAND,
	UMSATZSTEUERIDNR,
	WEITEREUSTID,
	PRUEFFELD,
	GEPRUEFTERINHALT,
	ZUSAETZLINFO,
	EKORG,
	FEHLERHAFTSEIT,
	FAEHLIGKEITSDATUM,
	REF_CALCULATION_TIME
) as
SELECT
    -- These are the columns to group by, representing the unique rows of the data
    CTR.REF_RULE_ID AS Regel_ID,
    rrl.CATALOG_ID AS CATALOG_ID,
    rrl.SHORT_DESCRIPTION_DE AS RegelKurzbeschreibung,
    rrl.ERROR_TEXT_DE AS Fehlermeldung,
    rrg.NAME_DE AS RegelgruppeName,
    rcr.NAME_DE AS Kritikalitaet,
    ito.SCORE,
    CTR.IDQ_TEST_OBJECT_ID AS Objekt_ID,
    ITO.SOURCE_SYSTEM_PRIMARY_KEY AS LiefNr,
    ITO.NAME AS Lieferant,
    ADI.StatusLieferant AS StatusLieferant,
    ADI.Kontengruppe AS Kontengruppe,
    ADI.EKS_NUMMER AS EKSNummer,
    ADI.Land_1 AS Land_1,
    ADI.M AS M,
    ADI.NF AS NF,
    ADI.EM AS EM,
    ADI.O_G AS O_G,
    ADI.B_P AS B_P,
    ADI.IMP AS IMP,
    ADI.VerhandelndesLand AS VerhandelndesLand,
    ADI.UMSATZSTEUER_IDNR AS UmsatzsteuerIdNr,
    ADI.WeitereUstID AS WeitereUstID,
    rf.NAME_DE AS Prueffeld,
    cei.INVALID_CONTENT AS GepruefterInhalt,
    cei.ADDITIONAL_INFO_DE AS ZusaetzlInfo,
    SUBSTRING(cei.ADDITIONAL_INFO_DE, 8, 4) AS EKORG,
    
    -- These are the aggregated columns, applying the MAX function to each group
    MAX(CTR.FIRST_NEGATIVE_TEST) AS Fehlerhaftseit,
    MAX(CTR.DUE_DATE) AS Faehligkeitsdatum,
    MAX(crbcs.check_rule_by_country_calculation_time) AS REF_CALCULATION_TIME
FROM
    dwh.CHECK_TEST_RESULT_1 ctr
    JOIN DWH.IDQ_TEST_OBJECT_1 ito ON ito.IDQ_TEST_OBJECT_ID = ctr.IDQ_TEST_OBJECT_ID
    JOIN idq_results.IDQ_ADDINFO_ZSM_SUPPLIER_SST_1 adi ON ito.IDQ_TEST_OBJECT_ID = adi.TEST_OBJECT_ID
    JOIN idq_results.REF_RULE_1 rrl ON CTR.REF_RULE_ID = rrl.ID
    JOIN idq_results.REF_REL_RULE_GROUP_RULE_1 rgr ON rrl.ID = rgr.RULE_ID
    JOIN idq_results.REF_RULE_GROUP_1 rrg ON rgr.RULE_GROUP_ID = rrg.ID
    JOIN idq_results.REF_CRITICALITY_1 rcr ON rcr.ID = rrl.CRITICALITY_ID
    JOIN idq_results.REF_FIELD_1 rf ON rf.ID = rrl.FIELD_ID
    JOIN idq_results.CHECK_ERROR_INFO_CURRENT_1 cei ON cei.TEST_OBJECT_ID = ito.IDQ_TEST_OBJECT_ID AND cei.RULE_ID = rrl.ID
    JOIN dwh.CHECK_RULE_BY_COUNTRY_SUMMARY_1 crbcs ON ctr.REF_RULE_ID = crbcs.ref_rule_id
WHERE
    ctr.REF_RULE_ID = 383 AND IS_ERROR_DETECTED = 1
GROUP BY
    -- All non-aggregated columns must be included in the GROUP BY clause
    Regel_ID,
    CATALOG_ID,
    RegelKurzbeschreibung,
    Fehlermeldung,
    RegelgruppeName,
    Kritikalitaet,
    SCORE,
    Objekt_ID,
    LiefNr,
    Lieferant,
    StatusLieferant,
    Kontengruppe,
    EKSNummer,
    Land_1,
    M,
    NF,
    EM,
    O_G,
    B_P,
    IMP,
    VerhandelndesLand,
    UmsatzsteuerIdNr,
    WeitereUstID,
    Prueffeld,
    GepruefterInhalt,
    ZusaetzlInfo,
    EKORG;