using System.Data;
using System.Data.SqlClient;
using System.Linq;

namespace Controllers
{
    public class DataProvider
    {
        private string connect = System.Web.Configuration.WebConfigurationManager.ConnectionStrings["PhoneManagement"].ConnectionString;

        private static DataProvider instance;

        public static DataProvider Instance
        {
            get
            {
                if (instance == null)
                {
                    instance = new DataProvider();
                }
                return DataProvider.instance;
            }
            set { DataProvider.instance = value; }
        }

        private DataProvider() { }

        private void GetParameter(string query, object[] parameter, SqlCommand command)
        {
            if (parameter != null)
            {
                string[] listPara = query.Split(' ');
                int i = 0;
                foreach (var item in listPara)
                {
                    if (item.Contains('@'))
                    {
                        command.Parameters.AddWithValue(item, parameter[i]);
                        i++;
                    }
                }
            }
        }

        public DataTable ExecuteQuery(string query, object[] parameter = null)
        {
            DataTable data = new DataTable();

            using (SqlConnection Connect = new SqlConnection(connect))
            {
                Connect.Open();
                SqlCommand command = new SqlCommand(query, Connect);

                GetParameter(query, parameter, command);

                SqlDataAdapter adapter = new SqlDataAdapter(command);
                adapter.Fill(data);

                Connect.Close();
            }

            return data;
        }

        public int ExecuteNonQuery(string query, object[] parameter = null)
        {
            int isOk = 0;
            using (SqlConnection Connect = new SqlConnection(connect))
            {
                Connect.Open();
                SqlCommand command = new SqlCommand(query, Connect);

                GetParameter(query, parameter, command);

                isOk = command.ExecuteNonQuery();

                Connect.Close();
            }
            return isOk;
        }

        public object ExecuteScalarQuery(string query, object[] parameter = null)
        {
            object data = 0;

            using (SqlConnection Connect = new SqlConnection(connect))
            {
                Connect.Open();
                SqlCommand command = new SqlCommand(query, Connect);

                GetParameter(query, parameter, command);

                data = command.ExecuteScalar();

                Connect.Close();
            }
            return data;
        }


    }
}
