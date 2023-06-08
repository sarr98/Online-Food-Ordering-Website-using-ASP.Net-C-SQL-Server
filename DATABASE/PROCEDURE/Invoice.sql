-- ================================================
-- Template generated from Template Explorer using:
-- Create Procedure (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- This block of comments will not be included in
-- the definition of the procedure.
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE Invoice
	-- Add the parameters for the stored procedure here
	@Action VARCHAR(10), 
	@PayementId INT=NULL, 
	@UserId INT=NULL, 
	@OrderDetailsId INT=NULL, 
	@Status VARCHAR(50)=NULL
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	--GET INVOICE BY ID
	IF @Action='INVOICEBYID'
		BEGIN
			SELECT ROW_NUMBER() OVER (ORDER BY (SELECT 1)) AS [SrNo], o.OrderNo , p.Name,p.Price,o.Quantity,
			(p.Price * o.Quantity) AS TotalPrice, o.OrderDate,o.Status From Orders o 
			INNER JOIN Products p ON p.ProductId = o.ProductId
			WHERE o.PayementId = @PayementId AND o.UserId = @UserId
		END

	--SELECT ORDER HISTORY
	IF @Action='ODRHISTORY'
		BEGIN
			SELECT DISTINCT o.PayementId , p.PayementMode , p.CardNo From  Orders o 
			INNER JOIN Payement p ON p.PayementId  = o.PayementId 
			WHERE o.UserId = @UserId
		END


	--GET ORDER STATUS
	IF @Action='GETSTATUS'
		BEGIN
			SELECT o.OrderDetailsId , o.OrderNo, (pr.Price * o.Quantity) AS TotalPrice, o.Status,
			o.OrderDate , p.PayementMode , pr.Name FROM Orders o
			INNER JOIN Payement p ON p.PayementId = o.PayementId
			INNER JOIN Products pr ON pr.ProductID = o.ProductId
		END



	--GET ORDER STATUS BY ID
	IF @Action='STATUSBYID'
		BEGIN
			SELECT OrderDetailsId, Status FROM Orders
			where OrderDetailsId = @OrderDetailsId
		END


	--UPDATE ORDER STATUS 
	IF @Action='UPDSTATUS'
		BEGIN
			UPDATE DBO.Orders 
			SET Status = @Status WHERE OrderDetailsId = @OrderDetailsId
		END

   
END
GO
