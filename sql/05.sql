-- PART 1:
-- Rewrite the SQL table below to use a maximally efficient column order.
-- You may directly modify this table.

/* ORIGINAL TABLE */
CREATE TABLE project (
    id SERIAL PRIMARY KEY, -- 4 bytes
    author_id BIGINT NOT NULL, -- 8 bytes
    target_type VARCHAR(2), -- -1 bytes
    target_id INTEGER, -- 4 bytes
    developer_addr INET, -- -1 bytes
    developer_id UUID, -- 16 bytes
    title CHAR(256), -- 1 bytes
    data TEXT, -- -1 bytes
    project_id INTEGER NOT NULL UNIQUE, -- 4 bytes
    action SMALLINT NOT NULL, -- 2 bytes
    created_at TIMESTAMP WITH TIME ZONE, -- 8 bytes
    updated_at TIMESTAMPTZ -- 8 bytes
);

/* MODIFIED TABLE */
CREATE TABLE project (
    developer_id UUID,
    author_id BIGINT NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE,
    updated_at TIMESTAMPTZ,
    id SERIAL PRIMARY KEY,
    target_id INTEGER,
    project_id INTEGER NOT NULL UNIQUE,
    action SMALLINT NOT NULL,
    title CHAR(256),
    target_type VARCHAR(2),
    developer_addr INET,
    data TEXT
);


-- PART 2:
-- Complete the table below describing the number of bytes used by the row created by the following insert statement.
-- Use the original column order defined above,
-- and not your modified order from part 1.

INSERT INTO project VALUES (
    0, -- 4 bytes, align=4 bytes
    55, -- 8 bytes, align=8 bytes
    NULL, -- 0 bytes
    NULL, -- 0 bytes
    NULL, -- 0 bytes
    'A0EEBC99-9C0B-4EF8-BB6D-6BB9BD380A11', -- 16 bytes, align=N/A
    NULL, -- 0 bytes
    NULL, -- 0 bytes
    88, -- 4 bytes, align=4 bytes
    12, --  2 bytes, align=2 bytes
    'now', -- 8 bytes, align=8 bytes
    '2022-03-09T18:34:27+00:00' -- 8 bytes, align=8 bytes
);

-- Header:  32 bytes (23 bytes struct; >1 byte bitmap; add padding so Header%8==0) 
-- Data: 56 bytes (see work below)
-- Padding: 0 padding (Header + Data = 88 bytes % 8 == 0)
-- Total: 88 bytes

/*
 * SERIAL: position 32; +4 bytes of data; +4 bytes of padding  
 * BIGINT: position 40; +8 bytes of data; +0 padding
 * UUID: position 48; +16 bytes of data; +0 padding
 * INTEGER: position 64; +4 bytes of data; +0 padding
 * SMALLINT: position 68; +2 bytes of data; +2 padding
 * TIMESTAMP: position 72; +8 bytes of data; +0 padding
 * TIMESTAMPTZ: position 80; +8 bytes of data
 */

SELECT pg_column_size(row(0::INTEGER,55::BIGINT,'A0EEBC99-9C0B-4EF8-BB6D-6BB9BD380A11'::UUID,
                          88::INTEGER,12::SMALLINT,'now'::TIMESTAMP,'2022-03-09T18:34:27+00:00'::TIMESTAMPTZ));
