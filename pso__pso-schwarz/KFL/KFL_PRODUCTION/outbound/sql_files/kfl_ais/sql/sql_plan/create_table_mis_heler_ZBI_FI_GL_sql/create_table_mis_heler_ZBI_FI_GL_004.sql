--[OK] statement is translated correctly (syntax and type checks are fine)


CREATE OR REPLACE TABLE dbp_etl.mis_heler (
    comp_code STRING(4),
    gl_account STRING(10),
    alloc_nmbr STRING(18),
    fiscyear INTEGER,
    fiscper3 INTEGER,
    ac_doc_no STRING(10),
    item_num INTEGER,
    deb_cre_lc NUMERIC(29, 2) DEFAULT 0.00,
    loc_currcy STRING(5),
    dcindic STRING(1),
    accdoctype STRING(5),
    doc_date STRING(8),
    pstng_date STRING(8),
    bus_area STRING(4),
    plant STRING(4),
    profit_ctr STRING(10),
    costcenter STRING(10)
);
