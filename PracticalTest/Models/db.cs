using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Threading.Tasks;

namespace PracticalTest.Models
{
    public class db
    {

        SqlConnection con = new SqlConnection("Data Source=DESKTOP-FMU92TI;Initial Catalog=SMS;User ID=sa;Password=Ayesh123");
        // For View record 
        public DataSet Empget(Staff empuser, out string msg)
        {
            DataSet ds = new DataSet();
            msg = "";
            try
            {
                SqlCommand com = new SqlCommand("Sp_User", con);
                com.CommandType = CommandType.StoredProcedure;
                com.Parameters.AddWithValue("@Id", empuser.Id);
                com.Parameters.AddWithValue("@UserName", empuser.UserName);
                com.Parameters.AddWithValue("@Password", empuser.Password);
                com.Parameters.AddWithValue("@Email", empuser.Email);
                com.Parameters.AddWithValue("@Status", empuser.Status);
                com.Parameters.AddWithValue("@Role", empuser.Role);
                com.Parameters.AddWithValue("@flag", empuser.flag);
                SqlDataAdapter da = new SqlDataAdapter(com);
                da.Fill(ds);
                msg = "OK";
                return ds;
            }
            catch (Exception ex)
            {
                msg = ex.Message;
                return ds;
            }
        }
        //For insert and update
        public string Empdml(Staff empuser, out string msg)
        {
            msg = "";
            try
            {
                SqlCommand com = new SqlCommand("Sp_User", con);
                com.CommandType = CommandType.StoredProcedure;
                com.Parameters.AddWithValue("@Id", empuser.Id);
                com.Parameters.AddWithValue("@UserName", empuser.UserName);
                com.Parameters.AddWithValue("@Password", empuser.Password);
                com.Parameters.AddWithValue("@Email", empuser.Email);
                com.Parameters.AddWithValue("@Status", empuser.Status);
                com.Parameters.AddWithValue("@Role", empuser.Role);
                com.Parameters.AddWithValue("@flag", empuser.flag);
                SqlDataAdapter da = new SqlDataAdapter(com);
                con.Open();
                com.ExecuteNonQuery();
                con.Close();
                msg = "OK";
                return msg;
            }
            catch (Exception ex)
            {
                if (con.State == ConnectionState.Open)
                {
                    con.Close();
                }
                msg = ex.Message;
                return msg;
            }
        }
    }
}
