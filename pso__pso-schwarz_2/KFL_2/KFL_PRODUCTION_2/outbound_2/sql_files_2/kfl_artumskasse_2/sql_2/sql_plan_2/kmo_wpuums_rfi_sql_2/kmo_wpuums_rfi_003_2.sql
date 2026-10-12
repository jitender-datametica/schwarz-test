/*
#------------------------------------------------------------------------------
# Skriptname   : kmo_wpuums_rfi.btq
# Erstelldatum : 06.11.2008
#------------------------------------------------------------------------------
# Skriptname   : kmo_wpuums_rfi.btq
# Erstelldatum : 06.11.2008
#------------------------------------------------------------------------------
# Projekt   : AIS KMO
# Kommentar : Datensaetze in Abhaengigkeit von RFI Freigabe loeschen/verschieben
# Quelle    : dbp_rfi.kmo_wpuums_2
# Ziel      : dbp_etl.kmo_wpuums_2
#------------------------------------------------------------------------------
# History:
#  06.11.2008  Michael Ueding  Ersterstellung
#  11.03.2009  Michael Ueding  Umbenennen der Ladetabelle
#  15.05.2009  Michael Ueding  Korrektur RFI Rueckfuehrung, damit "doppelte"
#                              korrekte Datensaetze innerhalb einer Cycle_id
#                              und Loop_id vollstaendig zurueckgefuehrt werden
#  17.05.2011  Michael Ueding  Erweiterung wg. Promotion
#------------------------------------------------------------------------------
# Processing Steps
#    1.) Logon auf der Datenbank
#    2.) Loeschen aller Daten mit Freigabe Status_2 = 1
#    3.) Daten mit den RFI Freigabestatus = 2 werden in die Loadtabelle veschoben
#    4.) Verschobene Daten aus der RFI Tabelle loeschen
#    5.) BTEQ beenden
#------------------------------------------------------------------------------
*/


/*
#------------------------------------------------------------------------------
# 2.) Loeschen aller Daten mit Freigabe Status_2 = 1
#------------------------------------------------------------------------------
*/


DELETE FROM dbp_rfi.kmo_wpuums_2
WHERE TRIM(rfi_freigabe) = '1';


/*
#------------------------------------------------------------------------------
# 3.) Korrigierte Daten mit RFI Freigabe 2 werden von der RFI-Umgebung_2 in die
#     Load Tabelle geladen
#------------------------------------------------------------------------------
*/


-- aktuellster Load 
INSERT INTO dbp_etl.kmo_wpuums_2 (
    segnam, landkz, filnr, refnum, belegdatum,
    belegwaers,
    qualartnr,
    artnr,
    aktionsnr,
    vorzmenge,
    umsmenge,
    vorzwert,
    umswert,
    mwtax,
    wgr,
    promotionart,
    vorzpromotion, umspromotion
)
(
    SELECT
        segnam,
        landkz,
        filnr,
        refnum,
        belegdatum,
        belegwaers,
        qualartnr,
        artnr,
        aktionsnr,
        vorzmenge,
        umsmenge,
        vorzwert,
        umswert,
        mwtax,
        wgr,
        promotionart,
        vorzpromotion,
        umspromotion
    FROM dbp_rfi.kmo_wpuums_2
    WHERE
        TRIM(rfi_freigabe) = '2'
        AND (-- kein eindeutiger logischer Schluessel
            segnam,
            landkz,
            filnr,
            refnum,
            belegdatum,
            belegwaers,
            qualartnr,
            artnr,
            COALESCE(aktionsnr, ''),
            vorzmenge,
            umsmenge,
            vorzwert,
            umswert,
            COALESCE(mwtax, ''),
            COALESCE(wgr, ''),
            vorzpromotion, umspromotion, promotionart, cycle_id * 1000 + loop_id
        ) IN (SELECT (
            segnam, landkz, filnr, refnum,
            belegdatum,
            belegwaers,
            qualartnr,
            artnr,
            a565252669,
            vorzmenge,
            umsmenge,
            vorzwert,
            umswert,
            a525727861,
            a519003276, vorzpromotion, umspromotion, promotionart, a293958980
        )
        FROM (
            SELECT
                segnam,
                landkz,
                filnr,
                refnum,
                belegdatum,
                belegwaers,
                qualartnr,
                artnr,
                COALESCE(aktionsnr, '') AS a565252669,
                vorzmenge,
                umsmenge,
                vorzwert,
                umswert,
                COALESCE(mwtax, '') AS a525727861,
                COALESCE(wgr, '') AS a519003276,
                vorzpromotion,
                umspromotion,
                promotionart,
                MAX(cycle_id * 1000 + loop_id) AS a293958980
            FROM dbp_rfi.kmo_wpuums_2
            WHERE TRIM(rfi_freigabe) = '2'
            GROUP BY
                segnam,
                landkz,
                filnr,
                refnum,
                belegdatum,
                belegwaers,
                qualartnr,
                artnr,
                a565252669,
                vorzmenge,
                umsmenge,
                vorzwert,
                umswert,
                a525727861,
                a519003276,
                vorzpromotion,
                umspromotion,
                promotionart
        ) AS t1_2)
);


/*
#------------------------------------------------------------------------------
# 4.) Loeschen der aus der RFI Umgebung_2 in die Load Umgebung_2 verschobenen
#     Datensaetze.
#------------------------------------------------------------------------------
*/


DELETE FROM dbp_rfi.kmo_wpuums_2
WHERE TRIM(rfi_freigabe) = '2';


/*
#------------------------------------------------------------------------------
# 5.) BTEQ beenden
#------------------------------------------------------------------------------
*/
