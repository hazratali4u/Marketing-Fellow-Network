using System;
using System.IO;
using System.Text;

namespace SAMS.Common.Classes
{
	/// <summary>
	/// Compression
	/// <author>Rizwan Ansari</author>
	/// <date></date>
	/// </summary>
	public class Compression
	{	
		#region Constructors
		public Compression()
		{
			//
			// TODO: Add constructor logic here
			//
		}
		#endregion
				
		#region Private Variables
		#endregion

		#region public Properties
		#endregion
		
		#region public static Methods
        //public static string CompressFiles(string p_filepath)
        //{
        //    string zipFileName = p_filepath.Substring(0,p_filepath.IndexOf('.'));//removing".txt" from filename
        //    zipFileName +=".zip";//attaching extension with filename
			
        //    //compress file
        //    try
        //    {
        //        // Output stream 
        //        java.io.FileOutputStream fos = new java.io.FileOutputStream(zipFileName); 

        //        // Tie to zip stream 
        //        java.util.zip.ZipOutputStream zos = new java.util.zip.ZipOutputStream(fos); 

        //        // Stream with source file 
        //        java.io.FileInputStream fis = new java.io.FileInputStream(p_filepath); 

        //        // It's our entry in zip 
        //        string filename = p_filepath.Substring(p_filepath.LastIndexOf('\\')).Remove(0,1);
        //        java.util.zip.ZipEntry ze = new java.util.zip.ZipEntry(filename ); 
        //        zos.putNextEntry(ze); 
        //        // Read and write until done 
        //        sbyte[] buffer = new sbyte[1024]; 
        //        int len; 

        //        // Read and write until done 
        //        while((len = fis.read(buffer)) >= 0) 
        //        { 
        //            zos.write(buffer, 0, len); 
        //        }
        //        // Close everything 
        //        zos.closeEntry(); 
        //        fis.close(); 
        //        zos.close(); 
        //        fos.close(); 
        //        //	m_LogMessage("Create zip file --> "+filename + " completed successfully");
				
        //        return zipFileName;
        //    }
        //    catch(Exception excp)
        //    {
        //        //	m_LogMessage(excp.Message);
        //        return null;
        //        //throw excp;
				
        //    }
        //}


        //public static string UnCompressFiles(string zipFileName)
        //{
        //    string txtFileName = "";
        //    string error = "";
        //    java.io.FileInputStream fis = null;
        //    java.util.zip.ZipInputStream zis = null;
        //    java.io.FileOutputStream fos = null;
        //    try
        //    {
        //        error = "fis new object excp for file" + zipFileName;
        //        if(File.Exists(zipFileName))
        //        {
        //            fis = new java.io.FileInputStream(zipFileName);
        //            error = "zis new";
        //            zis = new java.util.zip.ZipInputStream(fis);
				
        //            java.util.zip.ZipEntry ze2;
        //            sbyte[] buf = new sbyte[1024];
        //            int len;
        //            string fileName;
        //            while ((ze2 = zis.getNextEntry()) != null)
        //            {
        //                fileName = ze2.getName();
						
        //                txtFileName = fileName;
											
        //                //fileName = clsConstants.SyncLog_Monitor + fileName;
						
        //                fileName=zipFileName.ToLower().Replace("zip","txt");
						
						
        //                //	fileName = zipFileName;

        //                fos = new java.io.FileOutputStream(fileName);
												
        //                while ((len = zis.read(buf)) >= 0)
        //                {
        //                    fos.write(buf, 0, len);
        //                }
        //                txtFileName = zipFileName.Substring(0,zipFileName.IndexOf('.'));
        //                txtFileName += ".txt";
        //                fos.close();
        //            }
        //            return txtFileName;
        //        }
        //        else
        //        {
        //            return null;
        //        }
        //    }
        //    catch (Exception excp)
        //    {
        //        return null;
        //    } 
        //    finally 
        //    {
				
        //        try
        //        {
        //            if(fos!=null)
        //                fos.close();
        //        }
        //        catch
        //        {
        //            Console.WriteLine("ok");
        //        }
        //        if (zis!=null)
        //            zis.close();
        //        if (fis!=null)
        //            fis.close();
				
        //    }
        //    return txtFileName;
        //}
		
		#endregion

		#region Private Methods
		#endregion
		
		#region public Methods
		#endregion
	}
}
