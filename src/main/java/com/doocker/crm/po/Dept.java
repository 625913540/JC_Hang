package com.doocker.crm.po;

public class Dept {
    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column dept.id
     *
     * @mbggenerated Thu Jul 13 15:41:52 CST 2017
     */
    private Integer id;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column dept.dept_name
     *
     * @mbggenerated Thu Jul 13 15:41:52 CST 2017
     */
    private String deptName;

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column dept.id
     *
     * @return the value of dept.id
     *
     * @mbggenerated Thu Jul 13 15:41:52 CST 2017
     */
    public Integer getId() {
        return id;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column dept.id
     *
     * @param id the value for dept.id
     *
     * @mbggenerated Thu Jul 13 15:41:52 CST 2017
     */
    public void setId(Integer id) {
        this.id = id;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column dept.dept_name
     *
     * @return the value of dept.dept_name
     *
     * @mbggenerated Thu Jul 13 15:41:52 CST 2017
     */
    public String getDeptName() {
        return deptName;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column dept.dept_name
     *
     * @param deptName the value for dept.dept_name
     *
     * @mbggenerated Thu Jul 13 15:41:52 CST 2017
     */
    public void setDeptName(String deptName) {
        this.deptName = deptName == null ? null : deptName.trim();
    }
}