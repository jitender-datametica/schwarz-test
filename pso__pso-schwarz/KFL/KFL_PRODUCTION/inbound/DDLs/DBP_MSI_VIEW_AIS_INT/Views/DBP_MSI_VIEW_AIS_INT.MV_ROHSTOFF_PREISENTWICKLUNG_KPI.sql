CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_INT.MV_ROHSTOFF_PREISENTWICKLUNG_KPI
(
 ROHSTOFF_NR
,MaxPreisAeltesterMonat
,MaxPreisJuengsterMonat
)
AS
                                                                              
WITH MonatlichePreise AS (
    SELECT
        ROHSTOFF_NR,
        TO_VARCHAR(DAT_ROHSTOFF_PREIS, 'YYYYMM') AS KJMO,  -- Extrahiert Jahr und Monat
        AKT_MO,
        PREIS_ROHSTOFF_MAX
    FROM
        DBP_DATA.ROHSTOFF_PREISENTWICKLUNG v01
        JOIN DBP_DATA.TAG v02
        ON v01.KJWO = v02.KJWO
        AND v01.DAT_ROHSTOFF_PREIS = v02.dat
        WHERE AKT_MO BETWEEN -23 AND 0
        
), MinMaxMonate AS (
    SELECT
        MIN(KJMO) AS AeltesterMonat,
        MAX(KJMO) AS JuengsterMonat
    FROM
        MonatlichePreise
), MaxPreise AS (
  SELECT
        ROHSTOFF_NR,
        KJMO,
        MAX(PREIS_ROHSTOFF_MAX) AS PREIS_ROHSTOFF_MAX_KJMO,
        ROW_NUMBER() OVER (PARTITION BY ROHSTOFF_NR ORDER BY KJMO ASC) AS rn_asc,
        ROW_NUMBER() OVER (PARTITION BY ROHSTOFF_NR ORDER BY KJMO DESC) AS rn_desc
    FROM MonatlichePreise
    GROUP BY ROHSTOFF_NR, KJMO
)
SELECT
    mp.ROHSTOFF_NR,
    mpa.PREIS_ROHSTOFF_MAX_KJMO AS MaxPreisAeltesterMonat,
    mpd.PREIS_ROHSTOFF_MAX_KJMO AS MaxPreisJuengsterMonat
FROM MaxPreise mp
JOIN MinMaxMonate mm ON 1=1
LEFT JOIN MaxPreise mpa ON mp.ROHSTOFF_NR = mpa.ROHSTOFF_NR AND mpa.KJMO = mm.AeltesterMonat AND mpa.rn_asc = 1
LEFT JOIN MaxPreise mpd ON mp.ROHSTOFF_NR = mpd.ROHSTOFF_NR AND mpd.KJMO = mm.JuengsterMonat AND mpd.rn_desc = 1
QUALIFY ROW_NUMBER() OVER (PARTITION BY mp.ROHSTOFF_NR ORDER BY mp.KJMO) = 1; -- Deduplizierung
