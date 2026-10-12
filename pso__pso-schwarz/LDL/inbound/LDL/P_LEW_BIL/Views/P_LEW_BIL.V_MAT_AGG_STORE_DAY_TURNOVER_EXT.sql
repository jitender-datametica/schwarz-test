CREATE OR REPLACE VIEW P_LEW_BIL.V_MAT_AGG_STORE_DAY_TURNOVER_EXT 
(
  client_id                     
  ,src_orig_store_nr             
  ,dat_formdate                  
  ,currency_iso_cd               
  ,loc_sid_store                 
  ,cy_month                      
  ,cnt_customer
  ,cnt_customer_extrapol                
  ,val_rtl                       
  ,val_rtl_net                   
  ,val_rtl_extrapol              
  ,val_rtl_net_extrapol          
  ,val_rtl_kpges                 
  ,val_rtl_net_kpges             
  ,val_rtl_wawi                  
  ,val_rtl_net_wawi              
  ,val_rtl_txj                   
  ,val_rtl_net_txj               
  ,val_rtl_ejr                   
  ,val_rtl_net_ejr               
)
AS
SELECT
    COALESCE(basis.client_id,ext.client_id)                                                                          AS client_id
    ,COALESCE(basis.src_orig_store_nr,ext.src_orig_store_nr)                                                          AS src_orig_store_nr
    ,COALESCE(basis.dat_formdate,ext.dat_formdate)                                                                    AS dat_formdate
    ,COALESCE(basis.currency_iso_cd,ext.curr_cd_from)                                                                 AS currency_iso_cd
    ,COALESCE(basis.loc_sid_store,ext.loc_sid_store)                                                                  AS loc_sid_store
    ,COALESCE(basis.cy_month,ext.cy_month)                                                                            AS cy_month
    ,COALESCE(basis.cnt_customer,ext.cnt_customer)                                                                    AS cnt_customer
    ,CASE
        WHEN (basis.cnt_customer IS NULL OR basis.cnt_customer =0) AND ext.client_id IS NOT NULL THEN ZEROIFNULL(ext.cnt_customer_extrapol) 
        ELSE ZEROIFNULL(basis.cnt_customer) END                                                                       AS cnt_customer_extrapol
        
    ,basis.val_rtl                                                                                                    AS val_rtl
    ,basis.val_rtl_net                                                                                                AS val_rtl_net
    ,CASE
        WHEN (basis.val_rtl_net IS NULL OR basis.val_rtl_net=0) AND ext.client_id IS NOT NULL THEN ZEROIFNULL(ext.val_rtl_extrapol) 
        ELSE ZEROIFNULL(basis.val_rtl)
        END                                                                                                          AS val_rtl_extrapol
        
    ,CASE
        WHEN (basis.val_rtl_net IS NULL OR basis.val_rtl_net=0) AND ext.client_id IS NOT NULL THEN ZEROIFNULL(ext.val_rtl_net_extrapol) 
        ELSE ZEROIFNULL(basis.val_rtl_net)
        END                                                                                                          AS val_rtl_net_extrapol
       
    ,basis.val_rtl_kpges                                                                                              AS val_rtl_kpges
    ,basis.val_rtl_net_kpges                                                                                          AS val_rtl_net_kpges
    ,basis.val_rtl_wawi                                                                                               AS val_rtl_wawi
    ,basis.val_rtl_net_wawi                                                                                           AS val_rtl_net_wawi
    ,basis.val_rtl_txj                                                                                                AS val_rtl_txj
    ,basis.val_rtl_net_txj                                                                                            AS val_rtl_net_txj
    ,basis.val_rtl_ejr                                                                                                AS val_rtl_ejr
    ,basis.val_rtl_net_ejr                                                                                            AS val_rtl_net_ejr
FROM p_lew_bil.v_agg_store_day_turnover_base AS basis
FULL OUTER JOIN  ( -- Basisergebnis mit Hochrechnungen verknüpfen

    SELECT -- Part 1 - Data with no turnover (no customers) => turnover and customers will be extrapolated -- Wieso gibt es Umsätze, die 0 sind, obwohl Store offen hatte?
        sb.client_id
        ,sb.src_orig_store_nr
        ,sb.dat_open AS dat_formdate
        ,sb.curr_cd_from
        ,sb.loc_sid_store
        ,(EXTRACT (YEAR FROM e.cal_dt)*100 + EXTRACT (MONTH FROM e.cal_dt) ) AS cy_month
        ,sb.cnt_customer
        ,sb.val_rtl
        ,sb.val_rtl_net
        ,sb.val_rtl_kpges
        ,sb.val_rtl_net_kpges
        ,sb.val_rtl_wawi
        ,sb.val_rtl_net_wawi
        ,sb.val_rtl_txj
        ,sb.val_rtl_net_txj
        ,sb.val_rtl_ejr
        ,sb.val_rtl_net_ejr
        ,CASE WHEN MAX(sb.dat_open_md_storelist) IS NOT NULL THEN COALESCE(AVG(CASE WHEN f.val_rtl = 0 THEN NULL ELSE f.val_rtl END ),0)
            ELSE NULL
            END AS val_rtl_extrapol
        
        ,CASE WHEN MAX(sb.dat_open_md_storelist) IS NOT NULL THEN COALESCE(AVG(CASE WHEN f.val_rtl_net = 0 THEN NULL ELSE f.val_rtl_net END ),0)  
            ELSE NULL
            END AS val_rtl_net_extrapol
        ,CASE WHEN MAX(sb.dat_open_md_storelist) IS NOT NULL THEN COALESCE(AVG(CASE WHEN f.cnt_customer = 0 THEN NULL ELSE f.cnt_customer END ),0)
            ELSE NULL
            END AS cnt_customer_extrapol
    FROM ( ----Take ONLY those records which have 0s OR NULLS IN turnover for this store, client AND date   
    
        SELECT  
            COALESCE( mds.client_id, fs.client_id)                  AS client_id
            ,COALESCE( mds.loc_sid_store, fs.loc_sid_store)          AS loc_sid_store
            ,COALESCE(mds.src_orig_store_nr,fs.src_orig_store_nr)    AS src_orig_store_nr
            ,COALESCE( mds.dat_open, fs.dat_formdate)                AS dat_open
            ,mds.dat_open                                            AS dat_open_md_storelist
            ,fs.cnt_customer
            ,COALESCE( mds.curr_cd_from, fs.currency_iso_cd)         AS curr_cd_from
            ,fs.val_rtl
            ,fs.val_rtl_net
            ,fs.val_rtl_kpges
            ,fs.val_rtl_net_kpges
            ,fs.val_rtl_wawi
            ,fs.val_rtl_net_wawi
            ,fs.val_rtl_txj
            ,fs.val_rtl_net_txj
            ,fs.val_rtl_ejr
            ,fs.val_rtl_net_ejr -- Sublect aus erster Query  
        
        FROM p_lew_bil.v_agg_store_day_turnover_base AS fs  
        FULL OUTER JOIN ( -- Hole nur die Stores, die tatsächlich geöffnet waren. Anschließend wird src_orig_store_nr rangejoint, um einen Bezug zu Wawi herzustellen   
         -- Wenn in KPGES kein Information über die Öffnung eines Stores zu finden ist (val_indicator = NULL), dann nehme Information aus MD-Storelist --> !!BIL Layer!!    
        
            SELECT  
                mds.*
                ,curr.curr_cd_from
                ,skey.src_orig_store_nr
            FROM p_lew_bil.v_sys_md_storelist AS mds    
            INNER JOIN p_lew_core_ac.v_location AS skey 
                ON   mds.client_id = skey.client_id 
                AND  mds.loc_sid_store = skey.loc_sid   
            INNER JOIN p_lew_core_ac.v_exchange_rate_known_hist AS curr 
                ON curr.client_id = mds.client_id   
                AND CURRENT_DATE BETWEEN curr.active_from_dt AND curr.active_to_dt  
                AND CURRENT_DATE BETWEEN curr.dwh_valid_from AND curr.dwh_valid_to  
            INNER JOIN p_lew_core_ac.v_exchange_rate_type AS curr_type  
                ON curr_type.client_id = curr.client_id 
                AND curr_type.x_rate_type_sid = curr.x_rate_type_sid    
                AND curr_type.src_kurst = '@BEWE'   
            
            QUALIFY ROW_NUMBER() OVER (PARTITION BY mds.client_id,mds.loc_sid_store,mds.dat_open,curr.curr_cd_from
            ORDER BY src_orig_store_nr )=1  
        ) mds   
            ON   mds.dat_open = fs.dat_formdate 
            AND  mds.client_id = fs.client_id    
            AND  mds.src_orig_store_nr = fs.src_orig_store_nr    
            AND  mds.curr_cd_from  = fs.currency_iso_cd /*  
            #   
            # Only records which have 0s OR NULLS IN turnover FOR this store, client AND date   
            # stores with a valid dat_open have to be selected AND stores with only 
            # filled cnt_customer   
            # val_rtl_net column will be driving column for extrapolation   
            #   
            */
        WHERE ( fs.val_rtl_net = 0 OR fs.val_rtl_net IS NULL)
            AND  (( mds.dat_open IS NOT NULL ) OR ( mds.dat_open IS NULL AND fs.cnt_customer <> 0 ))
            AND  COALESCE( mds.dat_open, fs.dat_formdate) < CURRENT_DATE  
    ) sb    
    INNER JOIN p_lew_bil.v_cal_day_rel_extrapol AS e    
        ON e.cal_dt = sb.dat_open   
    LEFT OUTER JOIN (
        SELECT  
            client_id
            ,src_orig_store_nr
            ,dat_formdate
            ,currency_iso_cd
            ,loc_sid_store
            ,cy_month
            ,cnt_customer
            ,val_rtl
            ,val_rtl_net
        FROM p_lew_bil.v_agg_store_day_turnover_base
        WHERE dat_formdate < CURRENT_DATE   
    ) f 
        ON   e.dat_calendar_extrapol = f.dat_formdate   
        AND  sb.client_id = f.client_id  
        AND  sb.src_orig_store_nr = f.src_orig_store_nr  
        AND  sb.curr_cd_from = f.currency_iso_cd

    GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17  
)ext    
    ON   basis.client_id = ext.client_id  
    AND  basis.dat_formdate = ext.dat_formdate    
    AND  basis.src_orig_store_nr = ext.src_orig_store_nr   
    AND  basis.loc_sid_store = ext.loc_sid_store  
    AND  basis.currency_iso_cd = ext.curr_cd_from   
;
