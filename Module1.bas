Attribute VB_Name = "Module1"
Sub VBA_Challenge()
Dim ticker_symbol As String
Dim open_price As Double
Dim close_price As Double
Dim volume_of_stock As Integer
Dim quarterly_change As Double
Dim percent_change As Double
Dim total_stock_volume As Double
Dim summary_ticker_row As Integer

open_price = Cells(2, 3).Value
summary_ticker_row = 2
total_stock_volume = 0



'build table headers

Cells(1, 9).Value = "ticker symbol"
Cells(1, 10).Value = "Quarterly Change"
Cells(1, 11).Value = "percent Change"
Cells(1, 12).Value = "Total Stock Volume"

lastrow = Cells(Rows.Count, 1).End(xlUp).Row

'sort ticker sybmol into category

For i = 2 To lastrow
If Cells(i + 1, 1).Value <> Cells(i, 1).Value Then
   ticker_symbol = Cells(i, 1).Value

total_stock_volume = total_stock_volume + Cells(i, 7).Value



Range("I" & summary_ticker_row).Value = ticker_symbol
Range("L" & summary_ticker_row).Value = total_stock_volume

'find quarterly change


close_price = Cells(i, 6).Value
quarterly_change = (close_price - open_price)

Range("J" & summary_ticker_row).Value = quarterly_change

'find percent change

If open_price = 0 Then
percent_change = 0
Else
    percent_change = quarterly_change / open_price
End If

Range("K" & summary_ticker_row).Value = percent_change
Range("K" & summary_ticker_row).NumberFormat = "0.00%"

summary_ticker_row = summary_ticker_row + 1

total_stock_volume = 0

open_price = Cells(i + 1, 3)


Else
total_stock_volume = total_stock_volume + Cells(i, 7).Value


 End If
 
 
      Next i
        
 
  
  
 lastrow_summary_table = Cells(Rows.Count, 9).End(xlUp).Row
    
    'Conditional formatting'
    
    
        For i = 2 To lastrow_summary_table
            
            If Cells(i, 10).Value > 0 Then
               Cells(i, 10).Interior.ColorIndex = 10
            
            Else
                Cells(i, 10).Interior.ColorIndex = 3
                
            End If
        
        Next i

'new summery table'

Cells(2, 15).Value = "Greatest % Increase"
Cells(3, 15).Value = "Greatest % Decrease"
Cells(4, 15).Value = "Greatest Total Volume"
Cells(1, 16).Value = "Ticker"
Cells(1, 17).Value = "Value"

lastrow_summary_table = Cells(Rows.Count, 12).End(xlUp).Row

    For i = 2 To lastrow_summary_table
        
        If Cells(i, 11).Value = Application.WorksheetFunction.Max(Range("K2:K" & lastrow_summary_table)) Then
               Cells(2, 16).Value = Cells(i, 9).Value
               Cells(2, 17).Value = Cells(i, 11).Value
               Cells(2, 17).NumberFormat = "0.00%"
 
            ElseIf Cells(i, 11).Value = Application.WorksheetFunction.Min(Range("K2:K" & lastrow_summary_table)) Then
                   Cells(3, 16).Value = Cells(i, 9).Value
                   Cells(3, 17).Value = Cells(i, 11).Value
                   Cells(3, 17).NumberFormat = "0.00%"
            
         
            ElseIf Cells(i, 12).Value = Application.WorksheetFunction.Max(Range("L2:L" & lastrow_summary_table)) Then
                   Cells(4, 16).Value = Cells(i, 9).Value
                   Cells(4, 17).Value = Cells(i, 12).Value
            
            End If
        
        Next i


End Sub


