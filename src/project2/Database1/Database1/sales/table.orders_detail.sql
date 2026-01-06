CREATE TABLE [sales].[orders_detail]
(
	[id] INT NOT NULL PRIMARY KEY CLUSTERED IDENTITY(1,1),
	[order_id] INT NOT NULL,
	[product_id] INT NOT NULL,
	[quantity] INT NOT NULL,
	[price] DECIMAL(18, 2) NOT NULL,
)

GO

-- Add foreign key constraint on the order_id column referencing orders_header table
ALTER TABLE [sales].[orders_detail] ADD CONSTRAINT [FK_orders_detail_order_id] FOREIGN KEY([order_id]) REFERENCES [sales].[orders_header]([id])
GO
-- Add foreign key constraint on the product_id column referencing products table
ALTER TABLE [sales].[orders_detail] ADD CONSTRAINT [FK_orders_detail_product_id] FOREIGN KEY([product_id]) REFERENCES [sales].[products]([id])
GO
-- Create index on order_id column for faster lookups
CREATE NONCLUSTERED INDEX [IX_orders_detail_order_id] ON [sales].[orders_detail]([order_id] ASC)
GO