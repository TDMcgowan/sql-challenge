employee_title_salary = pd.read_sql("SELECT * FROM employees INNER JOIN titles ON employees.emp_title = titles.title_id INNER JOIN salaries ON employees.emp_no = salaries.emp_no", conn)
avg_data=employee_title_salary.groupby(["title"]).mean()["salary"].reset_index()
avg_data
bar_chart=plt.bar(avg_data['title'],avg_data['salary'])
x_axis = np.arange(len(avg_data['title']))
tick_locations = [value for value in x_axis]
plt.ylim(0,70000)
plt.xticks(tick_locations,avg_data['title'], rotation=90)
plt.title("Average Salary By Title")
plt.xlabel("Title")
plt.ylabel("Average Salary ($)")
plt.grid(color='#95a5a0', linestyle='--', linewidth=2, axis='y', alpha=0.7)
for i in bar_chart:
    yvalue = i.get_height()
    plt.text(i.get_x(), yvalue + 2000, "${:,.0f}K".format(yvalue/1000))
plt.savefig("Average Salary by Title.png")