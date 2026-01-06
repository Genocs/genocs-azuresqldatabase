CREATE TABLE [sales].[orders_header]
(
	[id] INT NOT NULL PRIMARY KEY CLUSTERED IDENTITY(1,1),
	[order_number] NVARCHAR(20) NOT NULL,
	[customer_id] INT NOT NULL,
	[order_date] DATETIME NOT NULL default (GETDATE()),
)

GO

-- Add constratint on the order_number column to be unique
ALTER TABLE [sales].[orders_header] ADD CONSTRAINT [UQ_orders_header_order_number] UNIQUE ([order_number])
GO

-- Add foreign key constraint on customer_id column referencing customers table
-- TODO: Remove the comments to enable the foreign key constraint
-- ALTER TABLE [sales].[orders_header] WITH CHECK ADD CONSTRAINT [FK_orders_header_customer_id] FOREIGN KEY([customer_id]) REFERENCES [sales].[customers]([id])
-- GO
