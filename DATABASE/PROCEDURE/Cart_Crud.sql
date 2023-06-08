
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Cart_Crud]
	-- Add the parameters for the stored procedure here
	@Action VARCHAR(10), 
	@ProductId INT=NULL, 
	@Quantity INT=NULL, 
	@UserId INT=NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	--SELECT
	IF @Action='SELECT'
		BEGIN
			SELECT c.ProductId,p.Name,p.ImageUrl,p.Price,c.Quantity as Qty,p.Quantity as PrdQty
			from dbo.Carts c
			INNER JOIN dbo.Products p ON p.ProductId=c.ProductId
			where c.UserId= @UserId
		END


	--INSERT
	IF @Action='INSERT'
		BEGIN
			INSERT INTO DBO.Carts(ProductId,Quantity,UserId)
			VALUES (@ProductId,@Quantity,@UserId)
		END


	--UPDATE
	IF @Action='UPDATE'
		BEGIN
			UPDATE DBO.Carts SET Quantity = @Quantity
			WHERE ProductId =@ProductId and UserId= @UserId
		END


	--DELETE
	IF @Action='DELETE'
		BEGIN
			DELETE FROM  DBO.Carts
			WHERE ProductId =@ProductId and UserId= @UserId
		END
 

	--GET BY ID (PRODUCTID & USERID)
	IF @Action='GETBYID'
		BEGIN
			SELECT * from dbo.Carts where ProductId =@ProductId and UserId= @UserId
		END

END
GO
