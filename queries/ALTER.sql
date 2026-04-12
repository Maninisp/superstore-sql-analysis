-- earlier sales, discount, profit col had NUMERIC data type e.g.Numeric(10,2), but we want to change it to FLOAT for better performance and flexibility in handling decimal values.
ALTER TABLE superstore
ALTER COLUMN sales    TYPE FLOAT,
ALTER COLUMN discount TYPE FLOAT,
ALTER COLUMN profit   TYPE FLOAT;

ALTER TABLE superstore
ALTER COLUMN sales    TYPE Numeric(10,2),
ALTER COLUMN discount TYPE Numeric(4,2),
ALTER COLUMN profit   TYPE Numeric(10,2);
