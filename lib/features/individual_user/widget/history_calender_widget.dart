import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../utils/app_colors.dart';

class HistoryCalendarWidget extends StatefulWidget {
  final DateTime? initialFromDate;
  final DateTime? initialToDate;
  final Function(DateTime fromDate, DateTime toDate) onDateSelected;
  final VoidCallback onClose;

  const HistoryCalendarWidget({
    super.key,
    this.initialFromDate,
    this.initialToDate,
    required this.onDateSelected,
    required this.onClose,
  });

  @override
  State<HistoryCalendarWidget> createState() => _HistoryCalendarWidgetState();
}

class _HistoryCalendarWidgetState extends State<HistoryCalendarWidget> {
  late DateTime? _selectedFromDate;
  late DateTime? _selectedToDate;
  bool _isSelectingFromDate = true;
  late DateTime _currentDisplayMonth;

  @override
  void initState() {
    super.initState();
    _selectedFromDate = widget.initialFromDate;
    _selectedToDate = widget.initialToDate;

    final now = DateTime.now();
    _currentDisplayMonth = DateTime(now.year, now.month);
  }

  void _goToPreviousMonth() {
    setState(() {
      _currentDisplayMonth = DateTime(
        _currentDisplayMonth.year,
        _currentDisplayMonth.month - 1,
      );
    });
  }

  void _goToNextMonth() {
    setState(() {
      _currentDisplayMonth = DateTime(
        _currentDisplayMonth.year,
        _currentDisplayMonth.month + 1,
      );
    });
  }

  void _handleSubmit() {
    if (_selectedFromDate != null && _selectedToDate != null) {
      widget.onDateSelected(_selectedFromDate!, _selectedToDate!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Calendar container
        Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: [
              // Header with close button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Task date',
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'Plus Jakarta Sans',
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    IconButton(
                      onPressed: widget.onClose,
                      icon: const Icon(Icons.close, size: 20),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Date selection fields
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    // From Date
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _isSelectingFromDate = true;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: _isSelectingFromDate
                                  ? AppColors.primaryColor
                                  : Colors.grey[300]!,
                              width: _isSelectingFromDate ? 2 : 1,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Date',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: 'Plus Jakarta Sans',
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey[600],
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                _selectedFromDate != null
                                    ? DateFormat('dd/MM/yyyy')
                                    .format(_selectedFromDate!)
                                    : '--/--/----',
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'Plus Jakarta Sans',
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: 16),

                    // To Date
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _isSelectingFromDate = false;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: !_isSelectingFromDate
                                  ? AppColors.primaryColor
                                  : Colors.grey[300]!,
                              width: !_isSelectingFromDate ? 2 : 1,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'To',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: 'Plus Jakarta Sans',
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey[600],
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                _selectedToDate != null
                                    ? DateFormat('dd/MM/yyyy')
                                    .format(_selectedToDate!)
                                    : '--/--/----',
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'Plus Jakarta Sans',
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Month header with navigation
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: _goToPreviousMonth,
                      icon: const Icon(Icons.chevron_left, size: 24),
                      style: IconButton.styleFrom(
                        backgroundColor: Colors.grey[100],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),

                    Text(
                      DateFormat('MMMM yyyy').format(_currentDisplayMonth),
                      style: const TextStyle(
                        fontSize: 16,
                        fontFamily: 'Plus Jakarta Sans',
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),

                    IconButton(
                      onPressed: _goToNextMonth,
                      icon: const Icon(Icons.chevron_right, size: 24),
                      style: IconButton.styleFrom(
                        backgroundColor: Colors.grey[100],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Calendar grid
              _buildCalendarGrid(_currentDisplayMonth),
            ],
          ),
        ),

        // Submit button
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: _handleSubmit,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryColor,
            foregroundColor: Colors.white,
            minimumSize: const Size(double.infinity, 48),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 0,
          ),
          child: const Text(
            'Submit',
            style: TextStyle(
              fontSize: 16,
              fontFamily: 'Plus Jakarta Sans',
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCalendarGrid(DateTime currentMonth) {
    final daysInMonth =
        DateTime(currentMonth.year, currentMonth.month + 1, 0).day;
    final firstDayOfMonth = DateTime(currentMonth.year, currentMonth.month, 1);
    final startingWeekday = firstDayOfMonth.weekday;

    // Adjust for Sunday as first day
    final adjustedWeekday = startingWeekday % 7;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          // Day headers
          Row(
            children: [
              _buildDayHeader('Sun'),
              _buildDayHeader('Mon'),
              _buildDayHeader('Tue'),
              _buildDayHeader('Wed'),
              _buildDayHeader('Thu'),
              _buildDayHeader('Fri'),
              _buildDayHeader('Sat'),
            ],
          ),

          // Calendar rows (5 rows)
          const SizedBox(height: 8),
          _buildCalendarRow(1, 7, currentMonth, adjustedWeekday),
          const SizedBox(height: 4),
          _buildCalendarRow(8, 14, currentMonth, adjustedWeekday),
          const SizedBox(height: 4),
          _buildCalendarRow(15, 21, currentMonth, adjustedWeekday),
          const SizedBox(height: 4),
          _buildCalendarRow(22, 28, currentMonth, adjustedWeekday),
          const SizedBox(height: 4),
          // Only show 5th row if needed
          if (daysInMonth > 28)
            _buildCalendarRow(29, daysInMonth, currentMonth, adjustedWeekday),
        ],
      ),
    );
  }

  Widget _buildDayHeader(String day) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Text(
          day,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 12,
            fontFamily: 'Plus Jakarta Sans',
            fontWeight: FontWeight.w600,
            color: Colors.grey[600],
          ),
        ),
      ),
    );
  }

  Widget _buildCalendarRow(int startDay, int endDay, DateTime currentMonth,
      int firstDayOffset) {
    final List<int?> dayNumbers = List.generate(7, (index) => null);

    // Calculate first day position
    final firstDayPosition = startDay == 1 ? firstDayOffset : 0;

    // Fill in days for current month
    int day = startDay;
    for (int i = firstDayPosition;
    i < 7 && day <= endDay && day <= DateTime(currentMonth.year, currentMonth.month + 1, 0).day;
    i++) {
      dayNumbers[i] = day;
      day++;
    }

    return Row(
      children:
      dayNumbers.map((day) => Expanded(child: _buildDayCell(day, currentMonth))).toList(),
    );
  }

  Widget _buildDayCell(int? dayNumber, DateTime currentMonth) {
    final bool isCurrentMonth = dayNumber != null;
    final DateTime? cellDate = isCurrentMonth
        ? DateTime(currentMonth.year, currentMonth.month, dayNumber!)
        : null;

    final bool isSelectedFrom = cellDate != null &&
        _selectedFromDate != null &&
        cellDate.year == _selectedFromDate!.year &&
        cellDate.month == _selectedFromDate!.month &&
        cellDate.day == _selectedFromDate!.day;

    final bool isSelectedTo = cellDate != null &&
        _selectedToDate != null &&
        cellDate.year == _selectedToDate!.year &&
        cellDate.month == _selectedToDate!.month &&
        cellDate.day == _selectedToDate!.day;

    // Only show range between dates, not including the endpoints
    final bool isInRange = cellDate != null &&
        _selectedFromDate != null &&
        _selectedToDate != null &&
        cellDate.isAfter(_selectedFromDate!) &&
        cellDate.isBefore(_selectedToDate!);

    final bool isToday = cellDate != null &&
        cellDate.year == DateTime.now().year &&
        cellDate.month == DateTime.now().month &&
        cellDate.day == DateTime.now().day;

    return GestureDetector(
      onTap: () {
        if (isCurrentMonth && dayNumber != null) {
          final selectedDate =
          DateTime(currentMonth.year, currentMonth.month, dayNumber);

          setState(() {
            if (_isSelectingFromDate) {
              _selectedFromDate = selectedDate;
              // If selecting From date that's after To date, clear To date
              if (_selectedToDate != null &&
                  _selectedFromDate!.isAfter(_selectedToDate!)) {
                _selectedToDate = null;
              }
            } else {
              _selectedToDate = selectedDate;
              // If selecting To date that's before From date, clear From date
              if (_selectedFromDate != null &&
                  _selectedToDate!.isBefore(_selectedFromDate!)) {
                _selectedFromDate = null;
              }
            }
          });
        }
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: isSelectedFrom || isSelectedTo
              ? AppColors.primaryColor
              : isInRange
              ? AppColors.primaryColor.withOpacity(0.1)
              : isToday
              ? AppColors.primaryColor.withOpacity(0.05)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
            color: isSelectedFrom || isSelectedTo
                ? AppColors.primaryColor
                : Colors.transparent,
            width: 2,
          ),
        ),
        child: Column(
          children: [
            // Day number
            Text(
              dayNumber != null ? dayNumber.toString() : '',
              style: TextStyle(
                fontSize: 14,
                fontFamily: 'Plus Jakarta Sans',
                fontWeight:
                isSelectedFrom || isSelectedTo ? FontWeight.bold : FontWeight.normal,
                color: isCurrentMonth
                    ? (isSelectedFrom || isSelectedTo ? Colors.white : Colors.black87)
                    : Colors.grey[400],
              ),
            ),
          ],
        ),
      ),
    );
  }
}